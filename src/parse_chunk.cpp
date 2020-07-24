// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(BH)]]

#include "parser.hpp"


// [[Rcpp::export]]
Rcpp::List check_chunk_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  client::ast::chunk expr;

  bool r = x3::phrase_parse(
    first, last,
    client::parser::chunk,
    x3::ascii::space,
    expr
  );

  Rcpp::Function f("Sys.sleep");
  f(0.2);

  Rcpp::Rcout << "r: " << r << " first == last: " << (last - first) << "\n";

  //if (first != last || !r) // fail if we did not get a full match
  //  Rcpp::stop("Failed to parse.");

  return Rcpp::wrap(expr);
}
