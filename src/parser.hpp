#ifndef PARSER_HPP
#define PARSER_HPP

//#define BOOST_SPIRIT_X3_DEBUG

#include <boost/config/warning_disable.hpp>
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/position_tagged.hpp>
#include <boost/spirit/home/x3/support/utility/error_reporting.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>
#include <boost/fusion/include/adapt_struct.hpp>
#include <boost/fusion/include/io.hpp>


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
    std::string engine; //, name;
    details d;
    //std::vector<option> options;
    //std::vector<std::string> code;
    std::string code;
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


// Wraps for chunk object

#include <RcppCommon.h>

namespace Rcpp {
  template <> SEXP wrap(client::ast::chunk const& chunk);
  template <> SEXP wrap(std::vector<client::ast::chunk> const& chunks);
  template <> SEXP wrap(std::vector<client::ast::option> const& opts);
}

#include <Rcpp.h>

namespace Rcpp {
  template <> SEXP wrap(client::ast::chunk const& chunk) {
    return Rcpp::List::create(
      Rcpp::Named("engine")  = chunk.engine,
      Rcpp::Named("name")    = chunk.d.name,
      Rcpp::Named("options") = Rcpp::wrap(chunk.d.options),
      Rcpp::Named("code") = chunk.code
    );
  };

  template <> SEXP wrap(std::vector<client::ast::chunk> const& chunks){
    return Rcpp::List(chunks.begin(), chunks.end());
  };

  template <> SEXP wrap(std::vector<client::ast::option> const& opts) {
    Rcpp::List values;
    Rcpp::CharacterVector names;

    for(auto opt : opts) {
      values.push_back(opt.value);
      names.push_back(opt.name);
    }

    values.attr("names") = names;

    return values;
  }
}



namespace client { namespace parser {

  namespace x3 = boost::spirit::x3;

  auto const engine = x3::rule<struct _, std::string> {"engine"}
    = x3::lexeme[ *x3::char_("A-Za-z0-9_") ];

  auto const option = x3::rule<struct _, client::ast::option>{"option"}
    = name >> x3::lit("=") >> expr;

  auto const details = x3::rule<struct _, client::ast::details>{"details"}
    = (  (name >> ',' >> (option % ','))
       | (x3::attr(std::string()) >> (option % ','))
       | (name >> -x3::lit(',') >> x3::attr(std::vector<ast::option>()))
       | (x3::attr(std::string()) >> x3::attr(std::vector<ast::option>()))
      );

  auto const code = x3::rule<struct _, std::string>{"code"}
    =  x3::raw[ x3::lexeme[ *(!x3::lit("\n```") >> ~x3::char_('`')) ] ];

  auto const chunk = x3::rule<struct _, client::ast::chunk>{"chunk"}
    = x3::lit("```{") >> engine >> details >> x3::lit("}") >> x3::eol >>
      code >> x3::eol >>
      x3::lit("```") >> x3::eol;



  //auto const chunk_def =
  //  // Chunk start
  //
  //    engine >>
  //    (name | x3::attr("")) >>
  //   -x3::lit(',') >>
  //    (option % ',')>>
  //  x3::lit("}");





  // >>
  //  // Code
  //  ( !x3::lit("```") >> x3::no_skip[ *x3::char_ ]) % x3::eol >>
  //  // Chunk end
  //  x3::lit("```") >>
  //    x3::eol;

  //BOOST_SPIRIT_DEFINE(chunk);
} }

#endif
