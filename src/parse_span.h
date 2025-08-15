#ifndef PARSE_SPAN_HPP
#define PARSE_SPAN_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parser_error_handler.h"
#include "parse_span_ast.h"
#include "parse_pandoc_attr.h"

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  struct span_class : error_handler {};
  x3::rule<span_class, client::ast::span> const span = "span";

  auto const span_def
  = x3::lit("[") >>
    x3::lexeme[ +("\\]" | (x3::char_ - ']' - x3::eol)) ] >> // span text
    x3::lit("]") >>
    cbrace_attrs;

  BOOST_SPIRIT_DEFINE(span);

  auto not_span = x3::rule<struct _> ("not a span")
  = x3::raw[*( !span >> (x3::char_ | x3::eol) )];

  auto const string_with_span = not_span >> *(span >> not_span);

} }

#endif