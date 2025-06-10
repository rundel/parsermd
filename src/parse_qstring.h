#ifndef PARSE_QSTRING_HPP
#define PARSE_QSTRING_HPP

#include <boost/spirit/home/x3.hpp>

namespace client { namespace parser {

  namespace x3 = boost::spirit::x3;
  auto const sq_string = x3::rule<struct _, std::string>{"single quoted string"}
                       = x3::lexeme[ '\'' >> *((x3::char_('\\') >> x3::char_("'")) | (x3::char_ - '\'')) >> '\'' ];

  auto const dq_string = x3::rule<struct _, std::string>{"double quoted string"}
                       = x3::lexeme[ '"' >> *((x3::char_('\\') >> x3::char_('"')) | (x3::char_ - '"')) >> '"' ];

  auto const bq_string = x3::rule<struct _, std::string>{"back quoted string"}
                       = x3::lexeme[ ( '`' > +(~x3::char_('`')) > '`' ) ];

  auto const q_string = x3::rule<struct _, std::string>{"single or double quoted string"}
                      = sq_string | dq_string;

  auto const any_q_string = x3::rule<struct _, std::string>{"single, double, or back quoted string"}
                          = sq_string | dq_string | bq_string;
} }

#endif
