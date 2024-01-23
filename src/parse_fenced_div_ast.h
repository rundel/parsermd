#ifndef PARSE_FENCED_DIV_AST_HPP
#define PARSE_FENCED_DIV_AST_HPP

//#define BOOST_SPIRIT_X3_DEBUG

#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/position_tagged.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct fdiv_open : x3::position_tagged {
    std::vector<std::string> attrs;
  };

  struct fdiv_close : x3::position_tagged {
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::fdiv_open,
  attrs
)

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::fdiv_close
)

#endif
