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
#include "parse_pandoc_attr.h"


namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  // Valid CSS class name parser - allows optional leading dot and letter start
  auto unbraced_class = x3::rule<struct _, std::string> ("unbraced class")
  = x3::raw[x3::char_(".a-zA-Z") >> *(x3::char_("a-zA-Z0-9_-"))];

  // Invalid unbraced class patterns (starts with number, double hyphen, underscore, etc.)
  auto invalid_unbraced_class = x3::rule<struct _> ("invalid unbraced class (must start with letter or dot)")
  = x3::lexeme[
      (x3::char_("0-9") |                           // starts with number
       (x3::lit("--") >> x3::char_("a-zA-Z")) |     // starts with --
       (x3::char_("_") >> x3::char_("a-zA-Z0-9")) | // starts with underscore
       (x3::char_("-") >> x3::char_("a-zA-Z0-9")))  // starts with single hyphen
    ];

  auto const block_start = x3::rule<struct _, client::ast::code_block_args> {"code block start"}
  = x3::lexeme[
      start_indent >>
      open_ticks(3)
  ] >>
  x3::omit[*x3::lit(" ")] >>
  (unbraced_class | (x3::eps > !invalid_unbraced_class) | x3::attr(std::string())) >>
  x3::omit[*x3::lit(" ")] >>
  (cbrace_attrs | x3::attr(client::ast::pandoc_attr())) >>
  *x3::lit(' ') >>
  x3::eol;

  auto const block_end = x3::rule<struct _> {"code block end (```)"}
  = x3::lexeme[
      x3::omit[ end_indent ] >>
      close_ticks(3)
    ] >>
    *x3::lit(" ") >>
    x3::eol;

  struct code_block_class : error_handler {};
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
