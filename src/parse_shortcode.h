#ifndef PARSE_SHORTCODE_HPP
#define PARSE_SHORTCODE_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parser_error_handler.h"
#include "parse_shortcode_ast.h"



namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  // See https://quarto.org/docs/extensions/shortcodes.html

  struct shortcode_class : error_handler, x3::annotate_on_success {};
  x3::rule<shortcode_class, client::ast::shortcode> const shortcode = "shortcode";

  auto func = x3::rule<struct _, std::string> ("function")
  = (!x3::lit(" >}}") > +(x3::char_ - x3::char_(" ")) );

  auto args = x3::rule<struct _, std::vector<std::string> > ("arguments")
  = *(!x3::lit(" >}}") > +(x3::lit(" ") | x3::eol) > +(x3::char_ - x3::char_(" ")));

  auto const shortcode_def
  = "{{< " >
    x3::lexeme[func > args] >
    " >}}";

  BOOST_SPIRIT_DEFINE(shortcode);
} }

#endif
