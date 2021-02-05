#ifndef PARSE_OPTION_AST_HPP
#define PARSE_OPTION_AST_HPP

#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/position_tagged.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct option : x3::position_tagged {
    std::string name, value;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::option,
  name, value
)

#endif
