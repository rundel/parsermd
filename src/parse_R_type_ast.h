#ifndef PARSE_R_TYPE_AST_HPP
#define PARSE_R_TYPE_AST_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/variant.hpp>
#include <boost/fusion/include/adapt_struct.hpp>


namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct R_type : x3::variant<bool, double, int, std::string> {
    using base_type::base_type;
    using base_type::operator=;
  };

  struct R_value {
    R_type x;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::R_value,
  x
)
#endif
