#ifndef PARSE_MARKDOWN_HPP
#define PARSE_MARKDOWN_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>

#include "parse_markdown_ast.h"

#include "parse_chunk.h"
#include "parse_code_block.h"
#include "parse_fenced_div.h"
#include "parse_yaml.h"


namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  // Markdown text stuff

  auto const partial_chunk_start = x3::lexeme[
      start_indent >>
      open_ticks(3) >>
      x3::lit("{")
    ];

  auto const partial_fdiv_start = x3::lexeme[
      x3::repeat(3, x3::inf)[x3::char_(':')]
    ];

  auto const md_line = x3::rule<struct _, std::string>{"markdown line"}
  = !(x3::lit("#") | partial_chunk_start | block_start | partial_fdiv_start | yaml_start) >> // skip invalid starts
    x3::lexeme[ +(x3::char_ - x3::eol) ];

  auto const md_lines = x3::rule<struct _, std::vector<std::string>>{"markdown lines"}
  = +(md_line >> x3::eol);

  auto const markdown = x3::rule<struct _, client::ast::markdown>{"markdown"}
  = md_lines;

} }

#endif
