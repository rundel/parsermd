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

  // Properly handle nested spans by using recursive matching
  // The key insight: parse anything that isn't a ']' followed by '{' at the same nesting level
  
  // Forward declaration for recursion
  struct span_text_class : error_handler {};
  x3::rule<span_text_class, std::string> const span_text = "span_text";
  x3::rule<struct nested_span_class, std::string> const nested_span = "nested_span";

  // Define nested span as a complete [text]{attrs} pattern
  auto const nested_span_def = x3::raw[
    '[' >> span_text >> "]{" >> +(x3::char_ - '}') >> '}'
  ];

  auto const span_text_def = x3::raw[
    x3::lexeme[
      +(
        x3::string("\\]")                 | // escaped ]
        x3::string("\\[")                 | // escaped [
        nested_span                       | // complete nested span
        ('[' >> +(x3::char_ - ']') >> ']' >> !x3::char_('{')) | // [text] not followed by { (not a span)
        (x3::char_ - ']' - x3::eol)         // any other character
      )
    ]
  ];

  BOOST_SPIRIT_DEFINE(nested_span, span_text);

  struct span_class : error_handler {};
  x3::rule<span_class, client::ast::span> const span = "span";

  auto const span_def
  = x3::lit("[") >>
    span_text >>
    x3::lit("]") >>
    cbrace_attrs;

  BOOST_SPIRIT_DEFINE(span);

  auto not_span = x3::rule<struct _> ("not a span")
  = x3::raw[*( !span >> (x3::char_ | x3::eol) )];

  auto const string_with_span = not_span >> *(span >> not_span);

} }

#endif