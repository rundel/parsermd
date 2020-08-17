// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(BH)]]

//#define BOOST_SPIRIT_X3_DEBUG

#include "parse_yaml.hpp"
#include "parse_chunk.hpp"
#include "parse_rmd.hpp"
#include "parser_rcpp_wrap.hpp"

#include <Rcpp.h>

// [[Rcpp::export]]
Rcpp::CharacterVector check_yaml_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  client::ast::yaml expr;

  bool r = x3::parse(
    first, last,
    client::parser::yaml,
    //x3::blank,
    expr
  );

  if (!r)
    Rcpp::stop("Failed to parse.");

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
Rcpp::List check_chunk_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  client::ast::chunk expr;

  //bool r = x3::phrase_parse(
  bool r = x3::parse(
    first, last,
    client::parser::chunk,
    //x3::blank,
    expr
  );

  if (!r) // fail if we did not get a full match
    Rcpp::stop("Failed to parse.");

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
Rcpp::List check_markdown_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  std::vector<client::ast::line> expr;

  bool r = x3::parse(
    first, last,
    +(client::parser::entry),
    //x3::blank,
    expr
  );

  if (!r) // fail if we did not get a full match
    Rcpp::stop("Failed to parse.");

  Rcpp::List res(expr.begin(), expr.end());


  return res;
}



// [[Rcpp::export]]
Rcpp::List check_markdown_heading_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  client::ast::heading expr;

  bool r = x3::parse(
    first, last,
    client::parser::heading,
    //x3::blank,
    expr
  );

  if (!r) // fail if we did not get a full match
    Rcpp::stop("Failed to parse.");

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
Rcpp::List check_option_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  std::vector<client::ast::option> expr;

  bool r = x3::parse(
    first, last,
    x3::skip(x3::blank)[ client::parser::option % "," ],
    //x3::blank,
    expr
  );

  if (!r)
    Rcpp::stop("Failed to parse.");

  return Rcpp::wrap(expr);
}
