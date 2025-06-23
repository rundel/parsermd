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

  static std::string::const_iterator str_start;
  struct _str_start{};
  static std::string::const_iterator expr_start;
  struct _expr_start{};

  auto set_str_start = [](auto& ctx) {
    x3::get<_str_start>(ctx).get() = _where(ctx).begin();
  };

  auto set_expr_start = [](auto& ctx) {
    x3::get<_expr_start>(ctx).get() = _where(ctx).begin();
  };

  auto find_pos = [](auto& ctx){
    int length = _where(ctx).begin() - x3::get<_expr_start>(ctx).get();
    int end = _where(ctx).begin() - x3::get<_str_start>(ctx).get();
    
    _attr(ctx).start = end - length;
    _attr(ctx).length = length;

    _val(ctx).push_back( _attr(ctx) );
   };

  auto not_shortcode = x3::rule<struct _> ("not shortcode")
  = x3::raw[*( x3::lit("{{{<") | (!x3::lit("{{<") >> (x3::char_ | x3::eol)) )];

  auto string_shortcodes = x3::rule<struct _, std::vector<client::ast::shortcode> > ("String with shortcodes")
  = x3::with<_str_start>(std::ref(str_start))[
    x3::with<_expr_start>(std::ref(expr_start))[
      x3::eps[set_str_start] >>
      not_shortcode[set_expr_start] >> 
      *(shortcode[find_pos] >> not_shortcode[set_expr_start] )
    ] ];


  /////////////////////////////////////////////////////////

  struct shortcode2_class : annotate_position {};
  x3::rule<shortcode2_class, client::ast::shortcode> const shortcode2 = "shortcode2";

  auto const shortcode2_def
  = shortcode_open >
    x3::lexeme[func > args] >
    shortcode_close;

  BOOST_SPIRIT_DEFINE(shortcode2);


  //auto string_shortcodes2 = x3::rule<struct _, std::vector<client::ast::shortcode> > ("String with shortcodes")
  auto const string_shortcodes2 = not_shortcode >> *(shortcode >> not_shortcode);

} }

#endif
