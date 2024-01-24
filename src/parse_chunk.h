#ifndef PARSE_CHUNK_HPP
#define PARSE_CHUNK_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parse_expr.h"
#include "parse_option.h"
#include "parser_error_handler.h"

#include "parse_chunk_ast.h"

#include "parse_indent.h"

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;




  auto const chunk_yaml_options = x3::rule<struct _, std::vector<std::string>> {"Chunk yaml options"}
  = x3::lexeme[*(yaml_option >> x3::eol)];


  // Chunk arg stuff
  auto const engine = x3::rule<struct _, std::string> {"chunk engine"}
  = (x3::lexeme[
       (x3::char_("=") > +x3::char_("A-Za-z0-9_")) |  // Pandoc raw attribute chunk
       (+x3::char_("A-Za-z0-9_"))                     // Rmd chunk engine
    ]);

  auto const label = x3::rule<struct _, std::string> {"chunk label"}
  = x3::lexeme[ +x3::char_("A-Za-z0-9#+_-") ] >> // Based on Sec 3.2 of the Sweave manual
    x3::skip(x3::blank)[ &(!x3::char_("=.")) ]; // Help disambiguate between labels and bad args


  // Chunk stuff

  static int n_ticks;
  struct _n_ticks{};

  auto chunk_tmpl_open = [](auto& ctx) {
    x3::get<_n_ticks>(ctx).get() =  x3::_attr(ctx).size();
  };
  auto chunk_tmpl_close = [](auto& ctx) {
    x3::_pass(ctx) = ( x3::_attr(ctx).size() == x3::get<_n_ticks>(ctx).get() );
  };

  auto const chunk_template_start = x3::rule<struct _> {"chunk template - start"}
   = x3::with<_n_ticks>(std::ref(n_ticks))[
    ( x3::skip(indent_pat)[
        x3::repeat(3, x3::inf)[ x3::char_("`") ][chunk_tmpl_open] >>
        x3::lit("{")
      ] >>
      !x3::char_("{.")
    ) >
    x3::skip(x3::blank)[
      *( // Look ahead to find end of chunk def
        &(!( (x3::lit('}') >> x3::eol) | x3::eol )) >>
        x3::char_
      ) >
      x3::lit('}') > x3::eol
    ]
  ];

  auto const chunk_template_body = x3::rule<struct _> {"chunk template - body"}
  = x3::with<_n_ticks>(std::ref(n_ticks))[ *(
        x3::skip(indent_pat)[
          !x3::repeat(3, x3::inf)[ x3::char_("`") ][chunk_tmpl_close]
        ] >>
        *(x3::char_ - x3::eol) >> x3::eol
  ) ];

  auto const chunk_template_end = x3::rule<struct _> {"chunk template - end"}
  = x3::with<_n_ticks>(std::ref(n_ticks))[
    x3::skip(indent_pat)[
      (   x3::repeat(3, x3::inf)[ x3::char_("`") ] >> x3::lit("{")
        | x3::repeat(3, x3::inf)[ x3::char_("`") ][chunk_tmpl_close] > x3::eol
      )
    ]
  ];

  auto const chunk_template = x3::rule<struct _> {"chunk template"}
  = chunk_template_start >>
    chunk_template_body >>
    chunk_template_end;


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
      ( (-x3::lit(',') >> &(!chunk_option))  // no option, comma optional
      | (x3::expect[x3::lit(',')] ) ) // yes option, comma required
  )[([](auto& ctx) {x3::_val(ctx) = x3::_attr(ctx);})];

  auto chunk_open = [](auto& ctx) {
    x3::get<_n_ticks>(ctx).get() =  x3::_attr(ctx).size();
    x3::_val(ctx) = x3::_attr(ctx).size();
  };
  auto chunk_close = [](auto& ctx) {
    x3::_pass(ctx) = ( x3::_attr(ctx).size() == x3::get<_n_ticks>(ctx).get() );
  };

  auto const open_ticks = x3::rule<struct _, int> {"open ticks"}
  = x3::with<_n_ticks>(std::ref(n_ticks)) [
    x3::repeat(3, x3::inf)[ x3::char_("`") ][chunk_open]
  ];

  auto const chunk_start = x3::rule<struct _, client::ast::chunk_args> {"chunk start"}
  = x3::lexeme[
      start_indent >>
      open_ticks >>
      x3::lit("{")
    ] >>
    x3::skip(x3::blank)[
      x3::expect[engine] >> -x3::lit(",") >>
      -(label_chunk) >>
      ((chunk_option % ',') | x3::attr(std::vector<ast::option>())) >> -x3::lit(",") >>
      x3::lit("}") >
      x3::eol
    ];


  auto const chunk_end = x3::rule<struct _> {"chunk end"}
  = x3::with<_n_ticks>(std::ref(n_ticks)) [ (
    ( x3::lexeme[
        x3::omit[ end_indent ] >>
          x3::repeat(3, x3::inf)[ x3::char_("`") ][chunk_close]
      ] >>
      *x3::lit(" ") >>
      x3::eol
    ) | (
      &x3::lexeme[
        x3::omit[ end_indent ] >>
        x3::repeat(3, x3::inf)[ x3::char_("`") ] >>
        x3::lit("{")
      ]
    )
  ) ];

  // Chunk can be ended by a new chunk starting see Yihui's book Sec 5.1.4
  // look ahead to match but not consume this new chunk

  // Code stuff

  auto const code_line = x3::rule<struct _, std::string, true> {"Chunk code line"}
  = x3::with<_n_ticks>(std::ref(n_ticks)) [
    (x3::raw[
       !( *indent_pat >>
          x3::repeat(3, x3::inf)[ x3::char_("`") ][chunk_close]
        ) >>
       *(x3::char_ - x3::eol)
    ]) [check_indent]
  ];

  auto const chunk_code = x3::rule<struct _, std::vector<std::string>> {"Chunk code"}
  = x3::lexeme[*(code_line >> x3::eol)];




  struct chunk_class : error_handler, x3::annotate_on_success {};
  x3::rule<chunk_class, client::ast::chunk> const chunk = "chunk";

  auto const chunk_def
    = x3::with<indent>(std::string()) [
        &chunk_template >> // look ahead check of chunk structure
        chunk_start >
        chunk_yaml_options >
        chunk_code >
        chunk_end
      ];

  BOOST_SPIRIT_DEFINE(chunk);

} }

#endif
