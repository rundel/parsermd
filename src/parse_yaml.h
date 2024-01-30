#ifndef PARSE_YAML_HPP
#define PARSE_YAML_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

#include "parser_error_handler.h"

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

  auto const yaml_fence_close = x3::rule<struct _>{"YAML closing fence"}
  = ((x3::lit("---") | x3::lit("...")) >> *x3::lit(' ')) >> x3::eol;

  auto const yaml_line = x3::rule<struct _, std::string>{"yaml line"}
  = !yaml_fence_close >>
    x3::raw[
      *(x3::char_ - x3::eol)
    ];

  auto const yaml_lines = x3::rule<struct _, std::vector<std::string>>{"yaml lines"}
  = *(yaml_line >> x3::eol);

  auto const post_fence_blank_line = x3::rule<struct _>{"YAML opening fence to be followed by a non-empty line"}
  = x3::eol >> &(!(*x3::lit(' ') >> x3::eol)); // Include eol so the error message shows on the fence line

  auto const yaml_start = x3::rule<struct _> {"yaml start"}
  = x3::lit("---") >> *x3::lit(' ') >> x3::eol >>
    &(!(*x3::lit(' ') >> x3::eol));

  struct yaml_class : error_handler, x3::annotate_on_success {};
  auto const yaml = x3::rule<yaml_class, client::ast::yaml> {"yaml"}
  = yaml_start >>
    x3::lexeme[ yaml_lines ] >>
    x3::expect[yaml_fence_close];
    //x3::lit("---") > *x3::lit(' ') > x3::eol;
} }

#endif
