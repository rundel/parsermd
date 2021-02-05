#ifndef PARSE_ERROR_HANDLER_HPP
#define PARSE_ERROR_HANDLER_HPP

#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/error_reporting.hpp>

#include <Rcpp.h>

namespace client { namespace parser {

  namespace x3 = boost::spirit::x3;
  namespace ascii = boost::spirit::x3::ascii;

  template <typename iter>
  void throw_parser_error(
      iter error_pos,
      iter doc_start, iter doc_end,
      iter expr_start, iter expr_end,
      std::string expected = "",
      bool debug = false
  ) {
    if (error_pos == doc_end)
      error_pos = std::prev(error_pos);

    iter line_start = std::find(
      std::make_reverse_iterator(error_pos),
      std::make_reverse_iterator(doc_start),
      '\n'
    ).base();

    iter line_end = std::find(error_pos, doc_end, '\n');

    int line_num = std::count(doc_start, error_pos, '\n') +1;

    if (expr_start < line_start)
      expr_start = line_start;

    if (expr_end > line_end)
      expr_end = line_end;

    //debug = true;

    if (debug) {
      Rcpp::Rcout << "line_start: " << line_start - line_start << "\n";
      Rcpp::Rcout << "expr_start: " << expr_start - line_start << "\n";
      Rcpp::Rcout << "error_pos : " << error_pos  - line_start << "\n";
      Rcpp::Rcout << "expr_end  : " << expr_end   - line_start << "\n";
      Rcpp::Rcout << "line_end  : " << line_end   - line_start << "\n";
      //Rcpp::Rcout << "expr      : " << std::quoted( std::string(expr_start, expr_end) ) << "\n";
      //Rcpp::Rcout << "doc       : " << std::quoted( std::string(doc_start, doc_end) ) << "\n";
      //Rcpp::Rcout << "error ctx : " << std::quoted( std::string(
      //  std::prev(error_pos, 5), std::next(error_pos, 5)
      //) ) << "\n";
    }


    std::stringstream ss;
    ss << "Failed to parse line " << line_num;
    if (expected != "") {
      if (expected.substr(0, 14) == "N5boost6spirit") {
        if (debug) {
          ss << ", expected " << "<unlabeled parser>";
        }
      } else {
        ss << ", expected " << expected;
      }
    }

    ss << "\n";

    ss << std::string(line_start, line_end) << "\n";
    char cur = ' ';
    for(iter i = line_start; i != line_end; ++i) {
      if      (i == error_pos)            cur = '^';
      else if (i == expr_start)           cur = '~';
      else if (std::prev(i) == error_pos) cur = '~';
      else if (std::prev(i) == expr_end)  cur = ' ';

      ss << cur;
    }

    if (error_pos == line_end)
      ss << '^';

    ss << "\n";

    throw Rcpp::exception(ss.str().c_str(), false);
  }


  struct error_handler {
    template <typename iter, typename error, typename context>
    x3::error_handler_result on_error(
      iter& expr_start, iter const& expr_end,
      error const& x, context const& c
    ) {
      auto& error_handler = x3::get<x3::error_handler_tag>(c).get();

      iter doc_start = error_handler.get_position_cache().first();
      iter doc_end   = error_handler.get_position_cache().last();


      throw_parser_error(x.where(), doc_start, doc_end,
                         expr_start, expr_end, x.which());

      return x3::error_handler_result::rethrow;
    }
  };

} }

#endif
