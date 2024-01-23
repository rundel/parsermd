#ifndef PARSE_RMD_HPP
#define PARSE_RMD_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>

#include "parse_fenced_div.h"
#include "parse_yaml.h"
#include "parse_indent.h"
#include "parse_chunk.h"
#include "parse_rmd_ast.h"

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  // Markdown text stuff
  auto const chunk_start_sig = (*indent_pat >> x3::lit("```{"));
  auto const heading_start_sig = x3::lit("#");
  auto const fdiv_start_sig = x3::lit(":::");
  auto const yaml_start_sig = x3::lit("---");

  auto const invalid_start = x3::rule<struct _>{"invalid start"}
  = chunk_start_sig | heading_start_sig | fdiv_start_sig | yaml_start_sig;

  auto const text_line = x3::rule<struct _, std::string>{"markdown text line"}
  = !invalid_start >> x3::lexeme[ *(x3::char_ - x3::eol) ];

  auto const text = x3::rule<struct _, std::vector<std::string>>{"markdown text"}
  = +(text_line >> x3::eol);

  // Rmd stuff
  auto const element = x3::rule<struct _, client::ast::element> {"rmd element"}
  = (chunk | heading | yaml | fdiv_close | fdiv_open | text) >> *x3::eol;

  auto const rmd = x3::rule<struct _, client::ast::rmd> {"rmd"}
  = *element;
} }

#endif
