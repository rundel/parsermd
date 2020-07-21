// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(BH)]]

#include "parser.hpp"

// [[Rcpp::export]]
std::string check_name_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  std::string name;

  bool r = x3::phrase_parse(
    first, last,
    client::parser::name,
    x3::ascii::space,
    name
  );

  if (first != last || !r) // fail if we did not get a full match
    Rcpp::stop("Failed to parse.");

  return name;
}

// [[Rcpp::export]]
Rcpp::CharacterVector check_option_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  client::ast::option expr;

  bool r = x3::phrase_parse(
    first, last,
    client::parser::option,
    x3::ascii::space,
    expr
  );

  if (first != last || !r) // fail if we did not get a full match
    Rcpp::stop("Failed to parse.");

  Rcpp::CharacterVector res;
  res.push_back(expr.value);
  res.attr("names") = expr.name;

  return res;
}

// [[Rcpp::export]]
Rcpp::CharacterVector check_option_list_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  std::vector<client::ast::option> expr;

  bool r = x3::phrase_parse(
    first, last,
    client::parser::option % ',',
    x3::ascii::space,
    expr
  );

  return Rcpp::wrap(expr);
}
