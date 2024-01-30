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
      *(!close_ticks(1)  >> x3::char_ - x3::eol)
    ];

  auto const inline_code = x3::rule<struct _, client::ast::inline_code> {"inline code"}
  = x3::lexeme[
      open_ticks(1) >>
      ( inline_engine | br_inline_engine) >>
      x3::lit(" ") >>
      inline_body >>
      close_ticks(1)
    ];
} }

#endif
