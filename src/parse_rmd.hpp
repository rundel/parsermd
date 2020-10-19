#ifndef PARSE_RMD_HPP
#define PARSE_RMD_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>

#include "parse_yaml.hpp"
#include "parse_chunk.hpp"

#include "parse_rmd_ast.hpp"

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto const chunk_start = (*indent_pat >> x3::lit("```{"));// >> x3::omit[ *(~x3::char_("}")) ] >> "}" >> x3::eol);
  auto const heading_start = x3::lit("#");

  auto const text_line = x3::rule<struct _, std::string>{"text line"}
  = !(chunk_start | heading_start) >> x3::lexeme[ *(x3::char_ - x3::eol) ];

  auto const text = x3::rule<struct _, std::vector<std::string>>{"text"}
  = +(text_line >> x3::eol);

  auto heading_level = ([](auto& ctx) { _val(ctx).level =  _attr(ctx).size(); });
  auto heading_name = ([](auto& ctx) { _val(ctx).name = _attr(ctx); });

  auto const heading = x3::rule<struct _, client::ast::heading> {"heading"}
  = (x3::repeat(1,6)[x3::char_("#")])[ heading_level ] >>
    -x3::lit(" ") >>
    ( *(x3::char_ - x3::eol) )[ heading_name ] >>
    x3::eol;

  auto const entry = x3::rule<struct _, client::ast::line> {"line"}
  = (chunk | heading | text) >> *x3::eol;

  auto const rmd = x3::rule<struct _, client::ast::rmd> {"rmd"}
  = -(yaml >> *x3::eol) >> *entry;
} }

#endif
