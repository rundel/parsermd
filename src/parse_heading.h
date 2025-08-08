#ifndef PARSE_HEADING_HPP
#define PARSE_HEADING_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

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

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto heading_level = ([](auto& ctx) { x3::_val(ctx).level =  x3::_attr(ctx).size(); });
  auto heading_name = ([](auto& ctx) { x3::_val(ctx).name = x3::_attr(ctx); });

  auto const heading = x3::rule<struct _, client::ast::heading> {"markdown heading"}
  = (x3::repeat(1,6)[x3::char_("#")])[ heading_level ] >>
    -x3::lit(" ") >>
    ( *(x3::char_ - x3::eol) )[ heading_name ] >>
    x3::eol;
} }

#endif
