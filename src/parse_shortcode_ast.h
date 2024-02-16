#ifndef PARSE_SHORTCODE_AST_HPP
#define PARSE_SHORTCODE_AST_HPP

//#define BOOST_SPIRIT_X3_DEBUG

#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/position_tagged.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct shortcode : x3::position_tagged {
    std::string func;
    std::vector<std::string> args;
  };

} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::shortcode,
  func, args
)

#endif
