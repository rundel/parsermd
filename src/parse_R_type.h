#ifndef PARSE_R_TYPE_HPP
#define PARSE_R_TYPE_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>

#include "parse_R_type_ast.h"


namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto const bool_value = x3::rule<struct _, bool> {"boolean"}
  = (x3::lit("TRUE") >> x3::attr(true)) | (x3::lit("FALSE") >> x3::attr(false));
  
  auto const int_value = x3::rule<struct _, int> {"integer"}
  = x3::int_ >> -x3::lit("L");
  
  auto const str_value = x3::rule<struct _, std::string> {"string"}
  = x3::raw[*x3::char_];

  auto const dbl_value = x3::rule<struct _, double> {"double"}
  = x3::double_ >> !x3::lit("L");
  //x3::real_parser<double, x3::strict_real_policies<double> > const dbl_value = {};

  // TODO - support complex?

  auto const R_value = x3::rule<struct _, client::ast::R_value> {"Basic R type"}
  = (bool_value >> !x3::char_) 
  | (dbl_value >> !x3::char_) 
  | (int_value >> !x3::char_)
  | str_value;

} }

#endif
