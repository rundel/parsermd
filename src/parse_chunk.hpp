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

  // Indent stuff

  // indent code based on https://stackoverflow.com/questions/62143841/spirit-x3-referring-to-a-previously-matched-value
  auto const indent_pat = x3::char_(" \t>");

  struct indent{};
  auto start_indent = x3::rule<struct _, std::string, true> {"start indent"}
    = (*indent_pat)
      [([](auto& ctx) {
        //Rcpp::Rcout << "start_indent:\n"
        //            << "attr   : " << std::quoted(_attr(ctx)) << "\n"
        //            << "val    : " << std::quoted(_val(ctx)) << "\n"
        //            << "indent : " << std::quoted(x3::get<indent>(ctx)) << "\n";

        //if (x3::get<indent>(ctx) == "")
        //  x3::get<indent>(ctx) = _attr(ctx);
        //
        //_val(ctx) = x3::get<indent>(ctx); // Needed to avoid weird concat behavior
        x3::get<indent>(ctx) = _attr(ctx);
      })];

  auto end_indent = x3::rule<struct _, std::string, true> {"end indent"}
    = (*indent_pat)
      [([](auto& ctx) {
        //Rcpp::Rcout << "end_indent " << std::quoted(_attr(ctx)) << "\n";
        _pass(ctx) = (x3::get<indent>(ctx) == _attr(ctx));
      })];

  auto check_indent = [](auto& ctx) {
    //Rcpp::Rcout << "check_indent " << x3::get<indent>(ctx).length() << "\n";
    size_t n = x3::get<indent>(ctx).length();
    _pass(ctx) = (x3::get<indent>(ctx) ==  _attr(ctx).substr(0, n)); // Compare the indents
    _attr(ctx).erase(0, n);                                          // erase the first n chars
                                                                     // so code line wont have indent
    _val(ctx) = _attr(ctx);
  };

  // Code stuff

  auto const code_line = x3::rule<struct _, std::string, true> {"Chunk code line"}
  = (x3::raw[
      !(*indent_pat >> x3::lit("```")) >>
      *(x3::char_ - x3::eol)
    ]) [check_indent];

  auto const chunk_code = x3::rule<struct _, std::vector<std::string>> {"Chunk code"}
  = x3::lexeme[ *(code_line >> x3::eol) ];


  // Chunk arg stuff

  auto const engine = x3::rule<struct _, std::string> {"chunk engine"}
  = (x3::lexeme[ +x3::char_("A-Za-z0-9_") ]);
  //[
  //  ([](auto& ctx){ _val(ctx) = _attr(ctx); }) //Override the default concat behavior
  //];

  auto const label = x3::rule<struct _, std::string> {"chunk label"}
  = x3::lexeme[ +x3::char_("A-Za-z0-9#+_-") ] >> // Based on Sec 3.2 of the Sweave manual
    x3::skip(x3::blank)[ &(!x3::char_("=")) ]; // Help disambiguate between labels and bad args


  // Chunk stuff

  auto const chunk_template = x3::rule<struct _> {"chunk template"}
  = x3::skip(indent_pat)[ x3::lit("```{") ] >
    x3::skip(x3::blank)[
      *(
          &(!( (x3::lit('}') >> x3::eol) | x3::eol )) >> // Look ahead to find end of chunk def
          x3::char_
      ) >
      x3::lit('}') > x3::eol
    ] >
    *(
        x3::skip(indent_pat)[ !x3::lit("```") ] >>
        *(x3::char_ - x3::eol) >> x3::eol
    ) >
    x3::skip(indent_pat)[ x3::lit("```") ];


  auto chunk_start_wrap = [](auto p) {
    return (
      x3::lexeme[ start_indent >> x3::lit("```{") ] >>
      x3::skip(x3::blank)[
        x3::expect[engine] >>
        -x3::lit(",") >>
        p >>
        x3::lit("}") >>
        x3::eol
      ]
    );
  };

  // This is needed otherwise backtracking not cleaning breaks things
  auto const label_chunk = x3::rule<struct _, std::string> {"label chunk"}
  = ( label >>
      ( (-x3::lit(',') >> &(!option))  // no option, comma optional
      | (x3::expect[x3::lit(',')] ) ) // yes option, comma required
  )[([](auto& ctx) {_val(ctx) = _attr(ctx);})];

  auto const chunk_start = x3::rule<struct _, client::ast::chunk_args> {"chunk start"}
  = x3::lexeme[ start_indent >> x3::lit("```{") ] >>
    x3::skip(x3::blank)[
      x3::expect[engine] >> -x3::lit(",") >>
      -(label_chunk) >>
      ((option % ',') | x3::attr(std::vector<ast::option>())) >
      x3::lit("}") >
      x3::eol
    ];

  //=   (  chunk_start_wrap( x3::attr(std::string()) >> x3::attr(std::vector<ast::option>()) )
  //     | chunk_start_wrap( label >> -x3::lit(',') >> x3::attr(std::vector<ast::option>()) )
  //     | chunk_start_wrap( x3::attr(std::string()) >> (option % ',') )
  //     | chunk_start_wrap( label > x3::lit(",") > (option % ',') )
  //    );


  auto const chunk_end = x3::rule<struct _> {"chunk end"}
  = (  x3::lexeme[ x3::omit[ end_indent ] >> x3::lit("```") ] >> *x3::lit(" ") >> x3::eol
    | &x3::lexeme[ x3::omit[ end_indent ] >> x3::lit("```{") ] );
  // Chunk can be ended by a new chunk starting see Yihui's book Sec 5.1.4
  // look ahead to match but not consume this new chunk

  struct chunk_class : error_handler, x3::annotate_on_success {};
  x3::rule<chunk_class, client::ast::chunk> const chunk = "chunk";

  auto const chunk_def
    = x3::with<indent>(std::string()) [
        //x3::eps[ ([](auto& ctx) {
        //  Rcpp::Rcout << "init :" << x3::get<indent>(ctx)  << "\n";
        //}) ] >>
        &chunk_template >> // look ahead check of chunk structure
        chunk_start >>
        chunk_code >>
        chunk_end
      ];

  BOOST_SPIRIT_DEFINE(chunk);

} }

#endif
