#ifndef PARSE_RMD_HPP
#define PARSE_RMD_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>

#include "parse_yaml.h"
#include "parse_chunk.h"

#include "parse_rmd_ast.h"

// TODO - probably something more elegant out there
std::string rtrim(std::string s) {
  s.erase(
    std::find_if(
      s.rbegin(), s.rend(),
      [](unsigned char ch) {return !std::isspace(ch);}
    ).base(),
  s.end());

  return s;
}


namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  // Markdown text stuff
  auto const chunk_start_sig = (*indent_pat >> x3::lit("```{"));
  auto const heading_start_sig = x3::lit("#");

  auto const text_line = x3::rule<struct _, std::string>{"markdown text line"}
  = !(chunk_start_sig | heading_start_sig) >> x3::lexeme[ *(x3::char_ - x3::eol) ];

  auto const text = x3::rule<struct _, std::vector<std::string>>{"markdown text"}
  = +(text_line >> x3::eol);


  // Heading stuff

  auto get_level = ([](auto& ctx) { _val(ctx).level =  _attr(ctx).size(); });
  auto get_name = ([](auto& ctx) { _val(ctx).name = rtrim( _attr(ctx) ); });
  auto get_classes = ([](auto& ctx) { _val(ctx).classes = _attr(ctx); });

  auto const heading_class = x3::rule<struct _, std::string> {"heading class"}
  = (x3::lexeme[
      x3::char_(".") >
      !x3::char_("0-9") > !x3::lit("--") > !(x3::char_("-") > x3::char_("0-9")) >
      +x3::char_("A-Za-z0-9_-")
    ]);

  auto const heading_classes = x3::rule<struct _, std::vector<std::string>> {"heading classes"}
  = x3::lit("{") >
    -(heading_class % ' ') >
    x3::lit("}");

  auto const heading = x3::rule<struct _, client::ast::heading> {"heading"}
  = (x3::repeat(1,6)[x3::char_("#")])[ get_level ] >> !x3::char_('#') >>
    -x3::lit(" ") >>
    ( *(x3::char_ - x3::eol - x3::char_("{")) )[ get_name ] >>
    *x3::lit(" ") >> -heading_classes[ get_classes ] >>
    x3::eol;

  // Rmd stuff
  auto const element = x3::rule<struct _, client::ast::element> {"rmd element"}
  = (chunk | heading | text) >> *x3::eol;

  auto const rmd = x3::rule<struct _, client::ast::rmd> {"rmd"}
  = -(yaml >> *x3::eol) >> *element;
} }

#endif
