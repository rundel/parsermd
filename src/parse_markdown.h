#ifndef PARSE_MARKDOWN_HPP
#define PARSE_MARKDOWN_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>

#include "parse_markdown_ast.h"

#include "parse_indent.h"
#include "parse_heading.h"
#include "parse_chunk.h"
#include "parse_code_block.h"
#include "parse_fenced_div.h"
#include "parse_yaml.h"


namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  // Inline code stuff

  auto r_engine = ([](auto& ctx) { x3::_val(ctx).name = std::string("r"); });

  auto const inline_engine = x3::rule<struct _, std::string> {"inline code engine"}
  //= x3::lexeme[(+x3::char_("A-Za-z0-9_"))];
  = x3::lexeme[x3::lit("r") >> x3::attr(std::string("r"))];

  auto const br_inline_engine = x3::rule<struct _, std::string> {"inline code curly brace engine"}
  = x3::lexeme[x3::lit("{") >> (+x3::char_("A-Za-z0-9_")) >> x3::lit("}")];

  auto const inline_body = x3::rule<struct _, std::string> {"inline code"}
  = x3::lexeme[*(!x3::lit("`") >> x3::char_ - x3::eol)];

  auto const inline_code = x3::rule<struct _, client::ast::inline_code> {"inline code"}
  = x3::lexeme[
      x3::lit("`") >>
      ( inline_engine | br_inline_engine) >>
      x3::lit(" ") >>
      inline_body >>
      x3::lit("`")
    ];

  // Markdown text stuff


  auto const md_text = x3::rule<struct _, std::string>{"markdown text"}
  = x3::lexeme[ +(!inline_code >> (x3::char_ - x3::eol)) ];

  auto const md_element = x3::rule<struct _, client::ast::md_element>{"markdown element"}
  = x3::lexeme[ inline_code | md_text ];

  auto const md_line = x3::rule<struct _, client::ast::md_line>{"markdown line"}
  = !(x3::lit("#") | chunk_start | block_start | fdiv_open | fdiv_close | yaml_start) >> // skip invalid starts
    x3::lexeme[ *md_element ] >> x3::eol;

  auto const markdown = x3::rule<struct _, client::ast::markdown>{"markdown"}
  = +md_line;

} }

#endif
