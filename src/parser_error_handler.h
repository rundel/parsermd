#ifndef PARSE_ERROR_HANDLER_HPP
#define PARSE_ERROR_HANDLER_HPP

#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/error_reporting.hpp>
#include <iomanip>

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

    // Focus on the error position and only show necessary context
    int line_num_start = std::count(doc_start, expr_start, '\n') + 1;
    int line_num_end = std::count(doc_start, error_pos, '\n') + 1;
    
    // Only show the line where the error occurs, unless the expression truly spans multiple lines
    // and we need context to understand the error
    std::vector<iter> line_starts;
    std::vector<iter> line_ends;
    std::vector<int> line_numbers;
    
    // If the error is on the same line as the expression start, only show that line
    if (line_num_start == line_num_end) {
      iter line_start = std::find(
        std::make_reverse_iterator(error_pos),
        std::make_reverse_iterator(doc_start),
        '\n'
      ).base();
      iter line_end = std::find(error_pos, doc_end, '\n');
      
      line_starts.push_back(line_start);
      line_ends.push_back(line_end);
      line_numbers.push_back(line_num_end);
    } else {
      // Multi-line case: show from expression start to error line
      iter current_line_start = std::find(
        std::make_reverse_iterator(expr_start),
        std::make_reverse_iterator(doc_start),
        '\n'
      ).base();
      
      iter search_pos = expr_start;
      int current_line_num = line_num_start;
      
      while (current_line_num <= line_num_end) {
        iter line_end = std::find(search_pos, doc_end, '\n');
        
        line_starts.push_back(current_line_start);
        line_ends.push_back(line_end);
        line_numbers.push_back(current_line_num);
        
        if (line_end == doc_end || current_line_num == line_num_end) {
          break;
        }
        
        search_pos = line_end + 1;
        current_line_start = search_pos;
        current_line_num++;
      }
    }
    
    // Calculate padding for line numbers
    int max_line_num = std::max(line_num_start, line_num_end);
    int padding = std::to_string(max_line_num).length();

    debug = false; // Turn off debug by default

    if (debug) {
      Rcpp::Rcout << "expr_start: " << expr_start - doc_start << "\n";
      Rcpp::Rcout << "error_pos : " << error_pos  - doc_start << "\n";
      Rcpp::Rcout << "expr_end  : " << expr_end   - doc_start << "\n";
      Rcpp::Rcout << "expr      : " << std::quoted( std::string(expr_start, expr_end) ) << "\n";
    }

    std::stringstream ss;

    if (line_num_start != line_num_end) {
      ss << "Failed to parse lines " << line_num_start << "-" << line_num_end;
    } else {
      ss << "Failed to parse line " << line_num_end;
    }
    
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

    // Display each line with proper formatting
    for (size_t i = 0; i < line_starts.size(); ++i) {
      iter line_start = line_starts[i];
      iter line_end = line_ends[i];
      int line_num = line_numbers[i];
      bool is_final_line = (line_num == line_num_end);
      bool is_single_line = (line_starts.size() == 1);
      
      // Line number with padding
      ss << std::setw(padding) << line_num << " | ";
      
      // Check if expression starts after the beginning of the line
      iter expr_start_on_line = std::max(expr_start, line_start);
      bool expr_starts_mid_line = (expr_start_on_line > line_start);
      
      // For single-line errors, always show the entire line
      if (is_single_line || !expr_starts_mid_line) {
        // Show full line content
        ss << std::string(line_start, line_end) << "\n";
        
        // Only show error indicators on the final line
        if (is_final_line) {
          // Error indicator line
          ss << std::string(padding + 3, ' ');
          
          // Calculate position for error indicator  
          char cur = ' ';
          for (iter j = line_start; j != line_end; ++j) {
            if (j == error_pos) cur = '^';
            else if (j == std::max(line_start, expr_start)) cur = '~';
            else if (std::prev(j) == error_pos) cur = '~';
            else if (std::prev(j) == std::min(line_end, expr_end)) cur = ' ';
            ss << cur;
          }
          
          if (error_pos == line_end) {
            ss << '^';
          }
          
          ss << "\n";
        }
      } else {
        // Multi-line case where expression starts mid-line
        ss << "...";
        // Show content from expression start to line end
        ss << std::string(expr_start_on_line, line_end) << "\n";
        
        // Only show error indicators on the final line
        if (is_final_line) {
          // Error indicator line
          ss << std::string(padding + 3, ' ');
          ss << "...";
          
          // Calculate position for error indicator
          char cur = ' ';
          for (iter j = expr_start_on_line; j != line_end; ++j) {
            if (j == error_pos) cur = '^';
            else if (j == expr_start_on_line) cur = '~';
            else if (std::prev(j) == error_pos) cur = '~';
            else if (j == std::min(line_end, expr_end)) cur = ' ';
            ss << cur;
          }
          
          if (error_pos == line_end) {
            ss << '^';
          }
          
          ss << "\n";
        }
      }
    }

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
