#ifndef PARSE_CODE_BLOCK_HPP
#define PARSE_CODE_BLOCK_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parser_error_handler.h"
#include "parse_code_block_ast.h"
#include "parse_indent.h"
#include "parse_ticks.h"


namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto const block_start = x3::rule<struct _, client::ast::code_block_args> {"code block start"}
  = x3::lexeme[
      start_indent >>
      open_ticks(3) >>
      *x3::lit(" ") >>
      *(x3::char_ - (x3::char_('`') | x3::eol))
  ] >>
  x3::eol;

  auto const block_end = x3::rule<struct _> {"chunk end"}
  = x3::lexeme[
      x3::omit[ end_indent ] >>
      close_ticks(3)
    ] >>
    x3::eol;

  struct code_block_class : error_handler, x3::annotate_on_success {};
  x3::rule<code_block_class, client::ast::code_block> const code_block = "code block";

  auto const code_block_def
  = x3::with<indent>(std::string()) [
    block_start >
    code_lines >
    block_end
  ];

  BOOST_SPIRIT_DEFINE(code_block);

} }

#endif
