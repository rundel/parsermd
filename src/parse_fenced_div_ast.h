#ifndef PARSE_FENCED_DIV_AST_HPP
#define PARSE_FENCED_DIV_AST_HPP

//#define BOOST_SPIRIT_X3_DEBUG

#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/position_tagged.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct key_value {
    std::string key;
    std::string value;
  };

  struct pandoc_attr : x3::position_tagged {
    std::string id;
    std::vector<std::string> classes;
    std::vector<key_value> kvs;
  };


  struct fdiv_open : x3::position_tagged {
    pandoc_attr attr;
  };

  struct fdiv_close : x3::position_tagged {
  };

  struct span : x3::position_tagged {
    std::string text;
    pandoc_attr attr;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::key_value,
  key, value
)

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::pandoc_attr,
  id, classes, kvs
)


BOOST_FUSION_ADAPT_STRUCT(
  client::ast::fdiv_open,
  attr
)

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::fdiv_close
)

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::span,
  text, attr
)

#endif
