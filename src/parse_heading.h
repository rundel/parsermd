#ifndef PARSE_HEADING_HPP
#define PARSE_HEADING_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

#include "parse_pandoc_attr_ast.h"
#include "parse_pandoc_attr.h"

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct heading {
    int level;
    std::string name;
    pandoc_attr attr;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::heading,
  level, name, attr
)

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto heading_level_rule = x3::rule<struct _, int> {"heading level"}
    = (x3::repeat(1,6)[x3::char_("#")])[([](auto& ctx) { x3::_val(ctx) = x3::_attr(ctx).size(); })];

  auto create_unnumbered_attr = [](auto& ctx) {
    client::ast::pandoc_attr attr;
    attr.classes.push_back(".unnumbered");
    x3::_val(ctx) = attr;
  };

  auto const unnumbered = x3::rule<struct _, client::ast::pandoc_attr> {"unnumbered attribute"}
  = x3::lit("{-}")[create_unnumbered_attr];

  // Handle edge cases with { so that we dont confuse the pandoc attribute parser
  auto const heading_name = x3::rule<struct _, std::string> {"heading name"}
  //= x3::raw[ *(x3::lit("]{") | x3::repeat(2, x3::inf)[ x3::char_("{") ] >> x3::lit("<") | x3::char_ - x3::eol - x3::char_("{")) ];
  = x3::raw[ *(   
       x3::lit(" ") >> x3::repeat(2, x3::inf)[ x3::char_("{") ] >> x3::lit("<") 
    | !x3::lit(" {") >> x3::char_ - x3::eol
  ) ];

  auto const heading = x3::rule<struct _, client::ast::heading> {"markdown heading"}
  = heading_level_rule >>
    -x3::lit(" ") >>
    heading_name >> 
    *x3::lit(" ") >>
    ( unnumbered | cbrace_attrs | x3::attr(client::ast::pandoc_attr()) ) >>
    *x3::lit(" ") >>
    x3::eol;
} }

#endif
