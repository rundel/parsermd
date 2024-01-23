// [[Rcpp::plugins(cpp17)]]
// [[Rcpp::depends(BH)]]

//#define BOOST_SPIRIT_X3_DEBUG

#include <boost/spirit/home/x3/support/utility/error_reporting.hpp>

#include <Rcpp.h>
#include <boost/format.hpp>

#include "parse_cbrace.h"

#include "parse_rmd.h"
#include "parser_rcpp_wrap.h"
#include "parser_error_handler.h"


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

  //if () // fail if we did not get a full match
  //  Rcpp::stop("Failed to parse.");

  if (!r || iter != end) {
    client::parser::throw_parser_error(
      iter, str.begin(), str.end(), str.begin(), str.end()
    );
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
  std::vector<client::ast::element> expr;
  parse_str(str, false, +(client::parser::element), expr);

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
Rcpp::List check_markdown_heading_parser(std::string const& str) {
  client::ast::heading expr;
  parse_str(str, false, client::parser::heading, expr);

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
Rcpp::List check_chunk_option_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::vector<client::ast::option> expr;
  auto const parser = x3::skip(x3::blank)[ client::parser::chunk_option % "," ];
  parse_str(str, false, parser, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
Rcpp::List check_yaml_option_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::vector<std::string> expr;
  auto const parser = x3::skip(x3::blank)[ client::parser::yaml_option % x3::eol ];
  parse_str(str, false, parser, expr);

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
Rcpp::CharacterVector check_fdiv_open_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  client::ast::fdiv_open expr;
  //auto const parser = x3::skip(x3::blank)[  ];
  parse_str(str, false, client::parser::fdiv_open, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
Rcpp::List check_fdiv_close_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  client::ast::fdiv_close expr;
  //auto const parser = x3::skip(x3::blank)[  ];
  parse_str(str, false, client::parser::fdiv_close, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
Rcpp::List check_shortcode_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  client::ast::shortcode expr;
  parse_str(str, false, client::parser::shortcode, expr);

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
Rcpp::CharacterVector check_cbrace_expr_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::string expr;
  auto const parser = x3::skip(x3::blank)[ client::parser::cbrace_expr ];
  parse_str(str, false, parser, expr);

  return Rcpp::wrap(expr);
}


//// [[Rcpp::export]]
//Rcpp::List check_fenced_div_parser(std::string const& str) {
//  namespace x3 = boost::spirit::x3;
//
//  client::ast::fdiv expr;
//  auto const parser = x3::skip(x3::blank)[ client::parser::fdiv ];
//  parse_str(str, false, parser, expr);
//
//  return Rcpp::wrap(expr);
//}

