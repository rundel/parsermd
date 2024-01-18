#ifndef PARSE_FENCED_DIV_HPP
#define PARSE_FENCED_DIV_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parser_error_handler.h"
#include "parse_fenced_div_ast.h"
#include "parse_cbrace.h"

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  struct fdiv_value_class : error_handler, x3::annotate_on_success {};
  x3::rule<fdiv_value_class, client::ast::fdiv_value> const fdiv_value = "fdiv_value";

  struct fdiv_class : error_handler, x3::annotate_on_success {};
  x3::rule<fdiv_class, client::ast::fdiv> const fdiv = "fdiv";


  auto const fdiv_value_def =
    fdiv | (x3::lexeme[ !x3::lit(":::") >> *(x3::char_ - x3::eol) ] >> x3::eol);

  // These are a bit easier than chunks since the number of :::'s don't need to match
  // See - https://pandoc.org/chunkedhtml-demo/8.18-divs-and-spans.html
  //
  // Also indenting is not supported so we ignore that as well
  // - See https://github.com/jgm/pandoc/issues/7936

  auto add_class = [](auto& ctx){ _val(ctx) = std::string(".") + _attr(ctx); };

  auto unbraced_word = x3::rule<struct _, std::string> {}
  %= x3::lexeme[ (+(x3::char_ - x3::eol - x3::blank))[add_class] ];

  auto const fdiv_def
    = x3::lexeme[x3::omit[ x3::repeat(3, x3::inf)[x3::char_(':')] ]] >>
         ( cbrace_expr | unbraced_word ) >>
         x3::omit[ *x3::char_(':') ] >> // ignore any trailing :s on the opening line
         x3::eol >>
      *fdiv_value >>
      x3::lexeme[ x3::omit[ x3::repeat(3, x3::inf)[x3::char_(':')] ] ] >> x3::eol;

  BOOST_SPIRIT_DEFINE(fdiv, fdiv_value);

} }

#endif
