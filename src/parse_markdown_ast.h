#ifndef PARSE_MARKDOWN_AST_HPP
#define PARSE_MARKDOWN_AST_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/variant.hpp>
#include <boost/fusion/include/adapt_struct.hpp>


namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct inline_code {
    std::string engine;
    std::string code;
  };

  struct md_element : x3::variant<inline_code, std::string> {
    using base_type::base_type;
    using base_type::operator=;
  };

  struct md_line {
    std::vector<md_element> elements;
  };

  struct markdown {
    std::vector<md_line> lines;
  };


} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::inline_code,
  engine, code
)

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::md_line,
  elements
)

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::markdown,
  lines
)

#endif
