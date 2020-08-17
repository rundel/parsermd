#ifndef PARSE_CHUNK_HPP
#define PARSE_CHUNK_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

#include "parse_expr.hpp"

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct option {
    std::string name, value;
  };

  struct details {
    std::string name;
    std::vector<option> options;
  };

  struct chunk {
    std::string engine;
    details d;
    std::vector<std::string> code;
    //std::string code;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::option,
  name, value
)

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::details,
  name, options
)

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::chunk,
  engine, d, code
)


namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto const engine = x3::rule<struct _, std::string> {"engine"}
    = x3::lexeme[ +x3::char_("A-Za-z0-9_") ];

  auto const r_name = x3::rule<struct _, std::string>{"name"}
    =   ( x3::lexeme[ x3::char_("A-Za-z") >> *x3::char_("._A-Za-z0-9") ] )
      | ( x3::lexeme[ x3::char_(".") >> !x3::char_("0-9") >> *x3::char_("._A-Za-z0-9") ] )
      | ( client::parser::any_q_string );

  auto const option = x3::rule<struct _, client::ast::option>{"option"}
    = r_name >> x3::lit("=") >> expr;

  // This spec is based on Sec 3.2 of the Sweave manual
  auto const label = x3::rule<struct _, std::string>{"chunk label"}
    = x3::lexeme[ x3::raw[ +x3::char_("A-Za-z0-9#+_-") ] ];

  auto const details = x3::rule<struct _, client::ast::details>{"details"}
    = (  (label >> ','            >> (option % ','))
       | (x3::attr(std::string()) >> -x3::lit(',') >> (option % ','))
       | (label >> -x3::lit(',')  >> x3::attr(std::vector<ast::option>()))
       | (x3::attr(std::string()) >> x3::attr(std::vector<ast::option>()))
      );

  auto const code = x3::rule<struct _, std::string>{"code"}
    = x3::raw[
        !x3::lit("```") >>
        *(x3::char_ - x3::eol)
      ];

  auto const chunk = x3::rule<struct _, client::ast::chunk>{"chunk"}
    = x3::lit("```{") >> engine >> details >> x3::lit("}") >> x3::eol >>
      x3::lexeme[ *(code >> x3::eol) ]>>
      x3::lit("```") >> x3::eol;
} }

#endif
