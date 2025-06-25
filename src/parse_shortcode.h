#ifndef PARSE_SHORTCODE_HPP
#define PARSE_SHORTCODE_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parser_error_handler.h"
#include "parse_shortcode_ast.h"
#include "parse_qstring.h"


namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  // See https://quarto.org/docs/extensions/shortcodes.html

  struct shortcode_class : error_handler {};
  x3::rule<shortcode_class, client::ast::shortcode> const shortcode = "shortcode";

  auto shortcode_open = x3::rule<struct _> ("shortcode open")
    = !x3::lit("{{{<") >> "{{<" >> +x3::lit(" ");

  auto shortcode_close = x3::rule<struct _> ("shortcode close")
    = *x3::lit(" ") >> ">}}";

  auto func = x3::rule<struct _, std::string> ("function")
  = +(!shortcode_close >> x3::char_ - x3::char_(" "));

  auto const unquoted_arg = x3::rule<struct _, std::string>{"unquoted argument"}
    = +( !shortcode_close >> 
         (  x3::char_ - x3::char_(" '\"") - x3::eol 
          | x3::char_('\\') >> x3::char_('\'') 
          | x3::char_('\\') >> x3::char_('"') )
       );

  auto const key_value_arg = x3::rule<struct _, std::string>{"key=value argument"}
    = x3::raw[
      +(x3::char_("a-zA-Z0-9_.-")) >> // key 
      '=' >> 
      (unquoted_arg | x3::raw[q_string]) // value
    ];

  auto args = x3::rule<struct _, std::vector<std::string> > ("arguments")
  = *(!shortcode_close >> +(x3::lit(" ") | x3::eol) >> (x3::raw[q_string] | key_value_arg | unquoted_arg));


  auto const shortcode_def
  = shortcode_open >
    x3::lexeme[func > args] >
    shortcode_close;

  BOOST_SPIRIT_DEFINE(shortcode);


  auto not_shortcode = x3::rule<struct _> ("not shortcode")
  = x3::raw[*( x3::lit("{{{<") | (!x3::lit("{{<") >> (x3::char_ | x3::eol)) )];

  auto const string_with_shortcodes = not_shortcode >> *(shortcode >> not_shortcode);


} }

#endif
