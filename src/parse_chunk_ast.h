#ifndef PARSE_CHUNK_AST_HPP
#define PARSE_CHUNK_AST_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/position_tagged.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

#include "parse_option_ast.h"

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct chunk_args : x3::position_tagged {
    std::string indent;
    std::string engine;
    std::string name;
    std::vector<option> chunk_options;
  };

  struct chunk : x3::position_tagged{
    chunk_args args;
    std::vector<std::string> yaml_options;
    std::vector<std::string> code;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::chunk_args,
  indent, engine, name, chunk_options
)

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::chunk,
  args, yaml_options, code
)
#endif
