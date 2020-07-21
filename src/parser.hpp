#ifndef PARSER_HPP
#define PARSER_HPP

#include <boost/config/warning_disable.hpp>
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/position_tagged.hpp>
#include <boost/spirit/home/x3/support/utility/error_reporting.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>
#include <boost/fusion/include/adapt_struct.hpp>
#include <boost/fusion/include/io.hpp>

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct option : x3::position_tagged {
    std::string name, value;
  };

  struct chunk : x3::position_tagged {
    std::string engine, name;
    std::vector<option> opts;
    std::string code;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::option,
  name, value
)


BOOST_FUSION_ADAPT_STRUCT(
  client::ast::chunk,
  engine, name, opts, code
)


// Wraps for chunk object

#include <RcppCommon.h>

namespace Rcpp {
  template <> SEXP wrap(client::ast::chunk const& attr);
  template <> SEXP wrap(std::vector<client::ast::chunk> const& attrs);
  template <> SEXP wrap(std::vector<client::ast::option> const& opts);
}

#include <Rcpp.h>

namespace Rcpp {
  template <> SEXP wrap(client::ast::chunk const& chunk) {
    return Rcpp::List::create(
      Rcpp::Named("name") = chunk.name,
      Rcpp::Named("engine") = chunk.engine,
      Rcpp::Named("code") = chunk.code,
      Rcpp::Named("options") = chunk.opts
    );
  };

  template <> SEXP wrap(std::vector<client::ast::chunk> const& chunks){
    return Rcpp::List(chunks.begin(), chunks.end());
  };

  template <> SEXP wrap(std::vector<client::ast::option> const& opts){
    Rcpp::CharacterVector name, value;
    for(auto const& opt : opts) {
      name.push_back(opt.name);
      value.push_back(opt.value);
    }
    value.attr("names") = name;

    return value;
  };
}



namespace client { namespace parser {

  namespace x3 = boost::spirit::x3;

  struct name_class;
  struct option_class;
  struct chunk_class;

  x3::rule<name_class, std::string> const name = "name";
  x3::rule<option_class, ast::option> const option = "option";
  x3::rule<chunk_class, ast::chunk> const chunk = "chunk";


  // A syntactically valid name consists of letters, numbers and the dot or underline
  // characters and starts with a letter or the dot not followed by a number. Names such as
  // ".2way" are not valid, and neither are the reserved words.
  auto const name_def = x3::raw[ x3::lexeme[ (
      ( x3::char_("A-Za-z") >> *x3::char_("._A-Za-z0-9") )                   // Starts with a letter
    | ( x3::char_(".") >> !x3::char_("0-9") >> *x3::char_("._A-Za-z0-9") )   // Starts with a .
    | ( '`' >> +(~x3::char_('`')) >> '`' )                                   // ` wrapped name
    | ( '"' > *("\\\"" >> x3::attr('"') | ~x3::char_('"')) > '"' )           // " wrapped name
    | ( '\'' > *("\\\'" >> x3::attr('\'') | ~x3::char_('\'')) > '\'' )       // ' wrapped name
  ) ] ];

  auto const option_def =  name >> x3::lit("=") >> x3::lexeme[+x3::char_];

  auto const chunk_def = x3::lit("```{}```");
  //  x3::lit("```{") >>
  //    ( name ) >>
  //    ( -(x3::rule<struct _, std::string> {} = name) >> -x3::lit(",") ) >>
  //    ( option % ',' ) >>
  //  x3::lit("}") >>
  //    ( x3::lexeme[ *x3::char_ ] ) >>
  //  x3::lit("```");

  //auto const selectors = +simple_selector;

  BOOST_SPIRIT_DEFINE(name, option, chunk);

  struct name_class {};
  struct option_class {};
  struct chunk_class {};
} }

#endif
