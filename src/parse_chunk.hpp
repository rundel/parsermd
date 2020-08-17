#ifndef PARSE_CHUNK_HPP
#define PARSE_CHUNK_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

#include <Rcpp.h>

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
    std::string indent;
    std::string engine;
    details d;
    std::vector<std::string> code;
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
  indent, engine, d, code
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



  // indent code based on https://stackoverflow.com/questions/62143841/spirit-x3-referring-to-a-previously-matched-value

  auto const indent_pat = x3::char_(" \t>");

  struct indent{};
  auto start_indent = x3::rule<struct _, std::string, true> {"start indent"}
    = (*indent_pat)
      [([](auto& ctx) { x3::get<indent>(ctx) = _attr(ctx); })];

  auto end_indent = x3::rule<struct _, std::string, true> {"end indent"}
    = (*indent_pat)
      [([](auto& ctx) { _pass(ctx) = (x3::get<indent>(ctx) == _attr(ctx)); })];


  auto const code = x3::rule<struct _, std::string, true> {"code"}
    = (x3::raw[
        !(*indent_pat >> x3::lit("```")) >>
        *(x3::char_ - x3::eol)
      ])
      [([](auto& ctx) {
        size_t n = x3::get<indent>(ctx).length();
        _pass(ctx) = (x3::get<indent>(ctx) ==  _attr(ctx).substr(0, n)); // Compare the indents
        _attr(ctx).erase(0, n);                                          // erase the first n chars
                                                                         // so code line wont have indent
        _val(ctx) = _attr(ctx);
      })];
  ;

  auto const chunk = x3::rule<struct _, client::ast::chunk, true>{"chunk"}
    = x3::with<indent>(std::string()) [
        x3::lexeme[ start_indent >> x3::lit("```{") ] >>
          x3::skip(x3::blank)[
            engine >> details >> x3::lit("}")
          ] >> x3::eol >>
        x3::lexeme[
          *(code >> x3::eol)  >>
          x3::omit[ end_indent ] >> x3::lit("```")
        ] >> x3::eol
      ];
} }

#endif
