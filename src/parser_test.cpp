// [[Rcpp::plugins(cpp17)]]
// [[Rcpp::depends(BH)]]

//#define BOOST_SPIRIT_X3_DEBUG

#include "parse_yaml.hpp"
#include "parse_chunk.hpp"

#include <Rcpp.h>

// [[Rcpp::export]]
Rcpp::CharacterVector check_yaml_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  client::ast::yaml expr;

  bool r = x3::phrase_parse(
    first, last,
    client::parser::yaml,
    x3::blank,
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

  bool r = x3::phrase_parse(
    first, last,
    client::parser::chunk,
    x3::blank,
    expr
  );

  if (!r) // fail if we did not get a full match
    Rcpp::stop("Failed to parse.");

  return Rcpp::wrap(expr);
}




#include "parse_rmd.hpp"



// [[Rcpp::export]]
Rcpp::List check_rmd_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  client::ast::rmd expr;

  bool r = x3::phrase_parse(
    first, last,
    client::parser::rmd,
    x3::blank,
    expr
  );

  Rcpp::Function f("Sys.sleep");
  f(0.2);

  Rcpp::Rcout << "r: " << r << " first == last: " << (last - first) << "\n";

  //if (first != last || !r) // fail if we did not get a full match
  //  Rcpp::stop("Failed to parse.");

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
Rcpp::List check_markdown_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  client::ast::markdown expr;

  bool r = x3::phrase_parse(
    first, last,
    client::parser::markdown,
    x3::blank,
    expr
  );

  if (!r) // fail if we did not get a full match
    Rcpp::stop("Failed to parse.");

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
Rcpp::List check_markdown_heading_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  client::ast::heading expr;

  bool r = x3::phrase_parse(
    first, last,
    client::parser::heading,
    x3::blank,
    expr
  );

  if (!r) // fail if we did not get a full match
    Rcpp::stop("Failed to parse.");

  return Rcpp::wrap(expr);
}
