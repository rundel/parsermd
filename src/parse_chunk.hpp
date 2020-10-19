#ifndef PARSE_CHUNK_HPP
#define PARSE_CHUNK_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parse_expr.hpp"
#include "parse_option.hpp"
#include "parser_error_handler.hpp"

#include "parse_chunk_ast.hpp"

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto const engine = x3::rule<struct _, std::string> {"engine"}
    = x3::lexeme[ +x3::char_("A-Za-z0-9_") ];

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

  struct chunk_class : error_handler, x3::annotate_on_success {};

  x3::rule<chunk_class, client::ast::chunk> const chunk = "chunk";

  auto const chunk_def //= x3::rule<struct _, client::ast::chunk, true>{"chunk"}
    = x3::with<indent>(std::string()) [
        // Chunk start
        x3::lexeme[ start_indent >> (x3::lit("```") > x3::lit("{")) ] >
        x3::skip(x3::blank)[
          engine >> -x3::lit(",") >> details
        ] >
        (x3::lit("}") >> x3::skip(x3::blank)[x3::eol]) >>
        // Chunk code
        x3::lexeme[ *(code >> x3::eol) ] >
        // Chunk end
        (    x3::lexeme[ x3::omit[ end_indent ] >> x3::lit("```") ] >> *x3::lit(" ") >> x3::eol
          | &x3::lexeme[ x3::omit[ end_indent ] >> x3::lit("```{") ] )
            // Chunk can be ended by a new chunk starting see Yihui's book Sec 5.1.4
            // nasdasdasdeed to match but not consume this new chunk
      ];
  BOOST_SPIRIT_DEFINE(chunk);



} }

#endif
