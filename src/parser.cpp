// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(BH)]]

//#define BOOST_SPIRIT_X3_DEBUG

#include "parse_rmd.hpp"
#include "parser_rcpp_wrap.hpp"
#include "parser_error_handler.hpp"
#include <Rcpp.h>
#include <boost/format.hpp>

#include <boost/spirit/home/x3/support/utility/error_reporting.hpp>



template <typename Parser, typename Attribute>
inline void parse_str(
    std::string const& str,
    bool allow_incomplete,
    Parser const& p,
    Attribute& attr,
    bool use_expect = false
) {
  namespace x3 = boost::spirit::x3;

  auto iter = str.begin();
  auto const end = str.end();

  using error_handler_type = x3::error_handler<std::string::const_iterator>;
  error_handler_type error_handler(iter, end, Rcpp::Rcout);

  auto const parser = x3::with<x3::error_handler_tag>(std::ref(error_handler))[ p ];

  bool r = x3::parse(iter, end, parser, attr);

  if (!r) // fail if we did not get a full match
    Rcpp::stop("Failed to parse.");

  if (iter != end) {
    //int parsed_lines = std::count(str.begin(), iter, '\n');
    //int total_lines = std::count(str.begin(), end, '\n');
    //
    //std::string msg = (
    //  boost::format("Incomplete parsing. Parsed %1% of %2% lines.")
    //  % parsed_lines % total_lines
    //).str();
    //

    //std::string msg {"Oops!"};

    Rcpp::stop(
      client::parser::gen_error_msg(iter, str.begin(), str.end(), str.begin(), str.end())
    );

    //if (allow_incomplete)
    //  Rcpp::warning(msg);
    //else
    //  Rcpp::stop(msg);
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


