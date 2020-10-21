#ifndef PARSE_OPTION_HPP
#define PARSE_OPTION_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parse_expr.hpp"
#include "parse_option_ast.hpp"
#include "parser_error_handler.hpp"

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto const r_name = x3::rule<struct _, std::string> {"valid R name"}
    = ( x3::lexeme[ x3::char_("A-Za-z") >> *x3::char_("._A-Za-z0-9") ] )
    | ( x3::lexeme[ x3::char_(".") >> x3::char_("._A-Za-z") >> *x3::char_("._A-Za-z0-9") ] )
    | ( client::parser::any_q_string );


  struct option_class : error_handler, x3::annotate_on_success {};
  x3::rule<option_class, client::ast::option> const option = "chunk option";

  auto const option_def = r_name > x3::lit("=") > expr;

  BOOST_SPIRIT_DEFINE(option);
} }

#endif
