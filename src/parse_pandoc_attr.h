#ifndef PARSE_PANDOC_ATTR_HPP
#define PARSE_PANDOC_ATTR_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parser_error_handler.h"
#include "parse_pandoc_attr_ast.h"
#include "parse_qstring.h"



namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;


  // For unbraced attributes add the css class decorator and convert to fdiv_open
  auto add_unbraced_class = [](auto& ctx){
    client::ast::pandoc_attr attr;
    attr.classes.push_back(std::string(".") + _attr(ctx));
    _val(ctx) = attr;
  };
  auto unbraced_attr = x3::rule<struct _, client::ast::pandoc_attr > ("unbraced attribute")
  = x3::lexeme[ (+(x3::char_ - x3::eol - x3::blank))[add_unbraced_class] ];

  auto id_attr = x3::rule<struct _, std::string> ("id attribute")  
  = x3::raw[ x3::lit("#") >> +(x3::char_("a-zA-Z0-9._-")) ];

  auto class_attr = x3::rule<struct _, std::string> ("class attribute")
  = x3::raw[ x3::lit(".") >> +(x3::char_("a-zA-Z0-9._-")) ];

  auto key_value_attr = x3::rule<struct _, client::ast::key_value> ("key=value attribute")
  = x3::raw[ +(x3::char_("a-zA-Z0-9_-")) ] >> 
    x3::lit("=") >> 
    x3::raw[ 
      ( x3::raw[q_string] |             // quoted value
        +(x3::char_ - x3::char_(" }"))  // unquoted value
    )];

  auto cbrace_attrs = x3::rule<struct _, client::ast::pandoc_attr > ("braced attribute(s)")
  = x3::lit("{") > x3::lexeme[
      (id_attr | x3::attr(std::string())) >> *x3::lit(" ") >
      (class_attr % +x3::lit(" ") | x3::attr(std::vector<std::string>())) >> *x3::lit(" ") >
      (key_value_attr % +x3::lit(" ") | x3::attr(std::vector<client::ast::key_value>())) > *x3::lit(" ")
    ] > x3::lit("}");
    
} }

#endif
