#ifndef PARSE_INLINE_CODE_HPP
#define PARSE_INLINE_CODE_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parse_ticks.h"
#include "parse_inline_code_ast.h"

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;


  auto const inline_engine = x3::rule<struct _, std::string> {"inline code engine"}
  = x3::lexeme[(+x3::char_("A-Za-z0-9_"))];

  auto const br_inline_engine = x3::rule<struct _, std::string> {"inline code curly brace engine"}
  = x3::lexeme[x3::lit("{") >> inline_engine >> x3::lit("}")];

  auto const inline_body = x3::rule<struct _, std::string> {"inline code"}
  = x3::lexeme[
      *(x3::char_ - x3::eol - x3::char_('`'))
    ];

  struct inline_code_class : error_handler {};
  x3::rule<inline_code_class, client::ast::inline_code> const inline_code = "inline code";

  auto const inline_code_def
  = x3::lexeme[
      x3::lit("`") >>
      ( inline_engine | br_inline_engine ) >>
      x3::lit(" ") >>
      inline_body >>
      x3::lit("`")
    ];
  
  BOOST_SPIRIT_DEFINE(inline_code);

  auto not_inline_code = x3::rule<struct _> ("not inline code")
  = x3::raw[*( !inline_code >> (x3::char_ | x3::eol) )];

  auto const string_with_inline_code = not_inline_code >> *(inline_code >> not_inline_code);
} }

#endif
