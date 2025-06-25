#ifndef PARSE_MARKDOWN_AST_HPP
#define PARSE_MARKDOWN_AST_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/variant.hpp>
#include <boost/fusion/include/adapt_struct.hpp>


namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct markdown : x3::position_tagged {
    std::vector<std::string> lines;
  };

} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::markdown,
  lines
)

#endif
