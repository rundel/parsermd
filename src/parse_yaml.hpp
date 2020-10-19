#ifndef PARSE_YAML_HPP
#define PARSE_YAML_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

#include "parser_error_handler.hpp"

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct yaml : x3::position_tagged {
    std::vector<std::string> lines;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::yaml,
  lines
)


namespace client { namespace parser {

  namespace x3 = boost::spirit::x3;

  struct content_class {};
  struct yaml_class : error_handler, x3::annotate_on_success {};

  x3::rule<content_class, std::string> const content = "content";
  x3::rule<yaml_class, client::ast::yaml> const yaml = "yaml";

  auto const content_def
  = x3::raw[
      !x3::lit("---") >>
      *(x3::char_ - x3::eol)
    ];

  auto const line = x3::rule<struct _, std::vector<std::string>>{"yaml line"}
  = *(content >> x3::eol);

  auto const yaml_def
  = x3::lit("---") > x3::eol >>
    x3::lexeme[ line ] >
    x3::lit("---") > x3::eol;

  BOOST_SPIRIT_DEFINE(content, yaml);
} }

#endif
