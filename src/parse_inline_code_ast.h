#ifndef PARSE_INLINE_CODE_AST_HPP
#define PARSE_INLINE_CODE_AST_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/position_tagged.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct inline_code : x3::position_tagged {
    int n_ticks;
    std::string engine;
    std::string code;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::inline_code,
  n_ticks, engine, code
)

#endif
