// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(BH)]]

//#define BOOST_SPIRIT_X3_DEBUG

#include "parse_rmd.hpp"
#include "parser_rcpp_wrap.hpp"
#include <Rcpp.h>
#include <boost/format.hpp>


// [[Rcpp::export]]
Rcpp::List parse_rmd_cpp(std::string const& str, bool allow_incomplete = false) {
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

  if (first != last) {
    int parsed_lines = std::count(str.begin(), first, '\n');
    int total_lines = std::count(str.begin(), last, '\n');

    std::string msg = (
      boost::format("Incomplete parsing. Parsed %1% of %2% lines.")
      % parsed_lines % total_lines
    ).str();

    if (allow_incomplete)
      Rcpp::warning(msg);
    else
      Rcpp::stop(msg);
  }

  return Rcpp::wrap(expr);
}

