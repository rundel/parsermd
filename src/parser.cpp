// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(BH)]]

//#define BOOST_SPIRIT_X3_DEBUG

#include "parse_rmd.hpp"
#include "parser_rcpp_wrap.hpp"
#include <Rcpp.h>
#include <boost/format.hpp>

template <typename Parser, typename Attribute>
inline void parse_str(
    std::string const& str,
    bool allow_incomplete,
    Parser const& p,
    Attribute& attr
) {
  namespace x3 = boost::spirit::x3;

  auto first = str.begin();
  auto last = str.end();

  bool r = x3::parse(first, last, p, attr);

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
}


// [[Rcpp::export]]
Rcpp::List parse_rmd_cpp(std::string const& str, bool allow_incomplete = false) {
  client::ast::rmd doc;
  parse_str(str, allow_incomplete, client::parser::rmd, doc);

  return Rcpp::wrap(doc);
}


// [[Rcpp::export]]
Rcpp::CharacterVector check_yaml_parser(std::string const& str) {
  client::ast::yaml expr;
  parse_str(str, false, client::parser::yaml, expr);

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
Rcpp::List check_chunk_parser(std::string const& str) {
  client::ast::chunk expr;
  parse_str(str, false, client::parser::chunk, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
Rcpp::List check_multi_chunk_parser(std::string const& str, bool allow_incomplete = false) {
  std::vector<client::ast::chunk> expr;
  parse_str(str, allow_incomplete, +client::parser::chunk, expr);

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
Rcpp::List check_markdown_parser(std::string const& str) {
  std::vector<client::ast::line> expr;
  parse_str(str, false, +(client::parser::entry), expr);

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
Rcpp::List check_markdown_heading_parser(std::string const& str) {
  client::ast::heading expr;
  parse_str(str, false, client::parser::heading, expr);

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
Rcpp::List check_option_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::vector<client::ast::option> expr;
  auto const parser = x3::skip(x3::blank)[ client::parser::option % "," ];
  parse_str(str, false, parser, expr);

  return Rcpp::wrap(expr);
}


