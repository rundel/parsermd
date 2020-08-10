// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(BH)]]

#define BOOST_SPIRIT_X3_DEBUG

#include "parse_rmd.hpp"
#include "parser_rcpp_wrap.hpp"
#include <Rcpp.h>

// [[Rcpp::export]]
Rcpp::List parse_rmd_debug(std::string const& str) {
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

  if (!r) // fail if we did not get a full match
    Rcpp::stop("Failed to parse.");

  return Rcpp::wrap(expr);
}

