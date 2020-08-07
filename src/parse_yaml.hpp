#ifndef PARSE_YAML_HPP
#define PARSE_YAML_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  typedef std::vector<std::string> yaml;
} }



namespace client { namespace parser {

  namespace x3 = boost::spirit::x3;

  auto const content = x3::rule<struct _, std::string>{"content"}
  = x3::raw[
      !x3::lit("---") >>
      *(x3::char_ - x3::eol)
    ];

  auto const yaml = x3::rule<struct _, client::ast::yaml>{"yaml"}
  = x3::lit("---") >> x3::eol >>
    x3::lexeme[ *(content >> x3::eol) ] >>
    x3::lit("---") >> x3::eol;
} }

#endif
