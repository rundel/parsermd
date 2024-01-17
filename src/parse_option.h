#ifndef PARSE_OPTION_HPP
#define PARSE_OPTION_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parse_expr.h"
#include "parse_option_ast.h"
#include "parser_error_handler.h"

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto const r_name = x3::rule<struct _, std::string> {"valid R name"}
    = ( x3::lexeme[ x3::char_("A-Za-z") >> *x3::char_("._A-Za-z0-9") ] )
    | ( x3::lexeme[ x3::char_(".") >> !x3::char_("0-9") >> *x3::char_("._A-Za-z0-9") ] )
    | ( client::parser::any_q_string );


  struct chunk_option_class : error_handler, x3::annotate_on_success {};
  x3::rule<chunk_option_class, client::ast::option> const chunk_option = "chunk option";

  auto const chunk_option_def = r_name > x3::lit("=") > expr;

  BOOST_SPIRIT_DEFINE(chunk_option);
} }


namespace client { namespace parser {
namespace x3 = boost::spirit::x3;

  //auto const yaml_key = x3::rule<struct _, std::string> {"valid yaml key"}
  //= ( x3::lexeme[ x3::char_("A-Za-z") >> *x3::char_("._A-Za-z0-9-") ] )
  //  | ( client::parser::any_q_string );


  struct yaml_option_class : error_handler, x3::annotate_on_success {};
  x3::rule<yaml_option_class, std::string> const yaml_option = "yaml option";


  // FIXME - Not a great pattern but we're looking for something followed by : followed by something,
  // doesn't handle edge cases with "s and other weird stuff but should be an ok start
  // Actual parsing of the yaml is handled by the yaml package later
  auto const yaml_option_def = (x3::lit("#| ") >>
                                x3::raw[
                                  +(x3::char_ - (x3::char_(":") | x3::eol)) >>
                                  x3::char_(":") >>
                                  +(x3::char_ - x3::eol)
                                ]);


  BOOST_SPIRIT_DEFINE(yaml_option);
} }

#endif
