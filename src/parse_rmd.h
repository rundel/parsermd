#ifndef PARSE_RMD_HPP
#define PARSE_RMD_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>

#include "parse_rmd_ast.h"

#include "parse_fenced_div.h"
#include "parse_yaml.h"
#include "parse_indent.h"
#include "parse_chunk.h"
#include "parse_shortcode.h"
#include "parse_code_block.h"

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  // fdiv counting

  struct _n_fdiv_open{
    int n;
    std::vector<client::ast::fdiv_open> fdivs;
  };
  static _n_fdiv_open n_fdiv_open;

  auto init_fdiv = [](auto& ctx) {
    x3::get<_n_fdiv_open>(ctx).get().n = 0;
  };

  auto open_fdiv = [](auto& ctx) {
    x3::get<_n_fdiv_open>(ctx).get().n++;
    x3::get<_n_fdiv_open>(ctx).get().fdivs.push_back(_attr(ctx));
  };

  auto close_fdiv = [](auto& ctx) {
    if (x3::get<_n_fdiv_open>(ctx).get().n == 0) {
      x3::_pass(ctx) = false;
    } else {
      x3::get<_n_fdiv_open>(ctx).get().n--;
      x3::get<_n_fdiv_open>(ctx).get().fdivs.pop_back();
    }
  };

  auto end_fdiv = [](auto& ctx) {
    // This is definitely not the right way to do this, but I can't devise anything better
    // without a crazy look ahead that is problematic based on fdivs being able to contain
    // chunks / code blocks that might contain fake fdivs

    if (x3::get<_n_fdiv_open>(ctx).get().n == 0) {
      x3::_pass(ctx) = true;
      return;
    }

    auto pos_cache = x3::get<x3::error_handler_tag>(ctx).get().get_position_cache();

    auto doc_start = pos_cache.first();
    auto doc_end = pos_cache.last();

    client::ast::fdiv_open fdiv = x3::get<_n_fdiv_open>(ctx).get().fdivs.back();
    auto fdiv_open_pos = pos_cache.position_of(fdiv);

    throw_parser_error(
      fdiv_open_pos.end()-1,
      doc_start, doc_end,
      fdiv_open_pos.begin(), fdiv_open_pos.end(),
      "to find closing div fence (:::), end of document reached."
    );
  };

  // Markdown text stuff

  auto const chunk_start_sig = (*indent_pat >> x3::lit("```"));
  //auto const chunk_start_sig = (*indent_pat >> x3::repeat(3, x3::inf)[ x3::lit("`") ] >> x3::lit("{"));
  auto const heading_start_sig = x3::lit("#");
  auto const fdiv_start_sig = x3::lit(":::");
  auto const yaml_start_sig = x3::lit(":::") >> *x3::lit(" ") >> x3::eol >> !(*x3::lit(' ') >> x3::eol);
  auto const shortcode_start_sig = x3::lit("{{<");


  auto const invalid_start = x3::rule<struct _>{"invalid start"}
  = !(heading_start_sig | chunk_start | block_start | fdiv_open | fdiv_close | yaml_start); //| shortcode_start_sig;

  auto const md_text_line = x3::rule<struct _, std::string>{"markdown text line"}
  = invalid_start >> x3::lexeme[ *(x3::char_ - x3::eol) ];

  auto const md_text = x3::rule<struct _, std::vector<std::string>>{"markdown text"}
  = +(md_text_line >> x3::eol);


  // Rmd stuff
  auto const element = x3::rule<struct _, client::ast::element> {"rmd element"}
  %= x3::with<_n_fdiv_open>(std::ref(n_fdiv_open))[
    (chunk | code_block | heading | yaml | fdiv_close[close_fdiv] | fdiv_open[open_fdiv] | md_text) >> *x3::eol
  ];

  x3::rule<struct rmd, client::ast::rmd> rmd {"rmd"};
  struct rmd_class : error_handler, x3::annotate_on_success {};

  auto const rmd_def = x3::rule<rmd_class, client::ast::rmd> {"rmd"}
  %= x3::with<_n_fdiv_open>(std::ref(n_fdiv_open))[
     x3::eps[init_fdiv] >>
     *element >>
     x3::eps[end_fdiv]
  ];

  BOOST_SPIRIT_DEFINE(rmd);

} }

#endif
