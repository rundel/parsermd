#ifndef PARSE_FENCED_DIV_HPP
#define PARSE_FENCED_DIV_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parser_error_handler.h"
#include "parse_fenced_div_ast.h"
#include "parse_qstring.h"
#include "parse_pandoc_attr.h"



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

    auto error_handler = x3::get<x3::error_handler_tag>(ctx).get();

    auto doc_start = error_handler.get_position_cache().first();
    auto doc_end = error_handler.get_position_cache().last();

    client::ast::fdiv_open& fdiv = x3::get<_n_fdiv_open>(ctx).get().fdivs.back();
    auto fdiv_open_pos = error_handler.position_of(fdiv);

    throw_parser_error(
      fdiv_open_pos.end()-1,
      doc_start, doc_end,
      fdiv_open_pos.begin(), fdiv_open_pos.end(),
      "to find closing div fence (:::), end of document reached."
    );
  };


  // These are a bit easier than chunks since the number of :::'s don't need to match
  // See - https://pandoc.org/chunkedhtml-demo/8.18-divs-and-spans.html
  //
  // Also indenting is not supported so we ignore that as well
  // - See https://github.com/jgm/pandoc/issues/7936

  struct fdiv_open_class : error_handler {};
  x3::rule<fdiv_open_class, client::ast::fdiv_open> const fdiv_open = "fdiv_open";

  auto const fdiv_open_def
  = x3::lexeme[x3::omit[ x3::repeat(3, x3::inf)[x3::char_(':')] ]] >>
    x3::skip(x3::blank)[
      (cbrace_attrs | unbraced_attr) >>
      x3::omit[ *x3::char_(':') ]   // ignore any trailing :s on the opening line
    ] >>
    x3::omit[*x3::blank] >> x3::eol;

  BOOST_SPIRIT_DEFINE(fdiv_open);


  struct fdiv_close_class : error_handler {};
  x3::rule<fdiv_close_class, client::ast::fdiv_close> const fdiv_close = "fdiv_close";

  auto const fdiv_close_def
  = x3::lexeme[ x3::omit[ x3::repeat(3, x3::inf)[x3::char_(':')] ] ] >> x3::omit[*x3::blank] >> x3::eol;

  BOOST_SPIRIT_DEFINE(fdiv_close);

} }

#endif
