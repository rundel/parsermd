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

  static int n_fdiv_open;
  struct _n_fdiv_open{};

  auto init_fdiv = [](auto& ctx) {
    x3::get<_n_fdiv_open>(ctx).get() = 0;
  };
  auto open_fdiv = [](auto& ctx) {
    x3::get<_n_fdiv_open>(ctx).get()++;
  };
  auto close_fdiv = [](auto& ctx) {
    if (x3::get<_n_fdiv_open>(ctx).get() == 0) {
      x3::_pass(ctx) = false;
    } else {
      x3::get<_n_fdiv_open>(ctx).get()--;
    }
  };
  auto end_fdiv = [](auto& ctx) {
    if (x3::get<_n_fdiv_open>(ctx).get() != 0) {
      x3::_pass(ctx) = false;
    }
  };

  // Markdown text stuff
  auto const chunk_start_sig = (*indent_pat >> x3::lit("```"));
  auto const heading_start_sig = x3::lit("#");
  auto const fdiv_start_sig = x3::lit(":::");
  //auto const yaml_start_sig = x3::lit("---");   // Don't need to check since this is valid md
  auto const shortcode_start_sig = x3::lit("{{<");

  auto const invalid_start = x3::rule<struct _>{"invalid start"}
  = chunk_start_sig | heading_start_sig | fdiv_start_sig; //| shortcode_start_sig;

  auto const text_line = x3::rule<struct _, std::string>{"markdown text line"}
  = !invalid_start >> x3::lexeme[ *(x3::char_ - x3::eol) ];

  auto const text = x3::rule<struct _, std::vector<std::string>>{"markdown text"}
  = +(text_line >> x3::eol);


  // Rmd stuff
  auto const element = x3::rule<struct _, client::ast::element> {"rmd element"}
  %= x3::with<_n_fdiv_open>(std::ref(n_fdiv_open))[
    (chunk | code_block | heading | yaml | shortcode | fdiv_close[close_fdiv] | fdiv_open[open_fdiv] | text) >> *x3::eol
  ];

  auto const rmd = x3::rule<struct _, client::ast::rmd> {"rmd"}
  %= x3::with<_n_fdiv_open>(std::ref(n_fdiv_open))[
     x3::eps[init_fdiv] >>
     *element >>
     x3::eps[end_fdiv]
  ];

} }

#endif
