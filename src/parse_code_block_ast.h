#ifndef PARSE_CODE_BLOCK_AST_HPP
#define PARSE_CODE_BLOCK_AST_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/position_tagged.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct code_block;


  struct code_block_args : x3::position_tagged {
    std::string indent;
    int n_ticks;
    std::string attr;
  };


  struct code_block : x3::position_tagged {
    code_block_args args;
    std::vector<std::string> code;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::code_block_args,
  indent, n_ticks, attr
)

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::code_block,
  args, code
)

#endif
