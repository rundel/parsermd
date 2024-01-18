#ifndef PARSE_FENCED_DIV_AST_HPP
#define PARSE_FENCED_DIV_AST_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/position_tagged.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

#include "parse_option_ast.h"

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct fdiv;

  struct fdiv_value : x3::variant< std::string, x3::forward_ast<fdiv> > {
    using base_type::base_type;
    using base_type::operator=;
  };

  struct fdiv : x3::position_tagged {
    std::string attributes;
    std::vector<fdiv_value> content;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::fdiv,
  attributes, content
)

#endif
