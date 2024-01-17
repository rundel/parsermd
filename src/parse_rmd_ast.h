#ifndef PARSE_RMD_AST_HPP
#define PARSE_RMD_AST_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/variant.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

#include "parse_yaml.h"
#include "parse_chunk_ast.h"

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct heading {
    int level;
    std::string name;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::heading,
  level, name
)

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct element : x3::variant<chunk, heading, std::vector<std::string>> {
    using base_type::base_type;
    using base_type::operator=;
  };

  struct rmd {
    yaml front_matter;
    std::vector<element> elements;
  };
  } }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::rmd,
  front_matter, elements
)

#endif
