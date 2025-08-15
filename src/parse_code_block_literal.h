#ifndef PARSE_CODE_BLOCK_LITERAL_HPP
#define PARSE_CODE_BLOCK_LITERAL_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parser_error_handler.h"
#include "parse_code_block_literal_ast.h"
#include "parse_indent.h"
#include "parse_ticks.h"


namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto const literal_attr_content = x3::rule<struct _, std::string> {"literal attribute content"}
  = x3::raw[*(
      (x3::char_('}') >> &(*(!x3::lit("}}") >> !x3::eol >> x3::char_) >> x3::lit("}}"))) // } only if }} still exists ahead
    | (x3::char_ - x3::char_('}'))                               // any non-} character
  )];

  auto const literal_block_start = x3::rule<struct _, client::ast::code_block_literal_args> {"code block literal start"}
  = x3::lexeme[
      start_indent >>
      open_ticks(3)
  ] >>
  *x3::lit(" ") >>
  x3::lit("{{") >>
  literal_attr_content >>
  x3::lit("}}") >>
  *x3::lit(' ') >>
  x3::eol;

  auto const literal_block_end = x3::rule<struct _> {"code block literal end (```)"}
  = x3::lexeme[
      x3::omit[ end_indent ] >>
      close_ticks(3)
    ] >>
    *x3::lit(" ") >>
    x3::eol;

  struct code_block_literal_class : error_handler {};
  x3::rule<code_block_literal_class, client::ast::code_block_literal> const code_block_literal = "code block literal";

  auto const code_block_literal_def
  = x3::with<indent>(std::string()) [
    literal_block_start >
    code_lines >
    literal_block_end
  ];

  BOOST_SPIRIT_DEFINE(code_block_literal);

} }

#endif