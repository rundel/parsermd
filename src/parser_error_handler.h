#ifndef PARSE_ERROR_HANDLER_HPP
#define PARSE_ERROR_HANDLER_HPP

#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/error_reporting.hpp>
#include <iomanip>
#include <Rcpp.h>

namespace client { namespace parser {

  namespace x3 = boost::spirit::x3;
  namespace ascii = boost::spirit::x3::ascii;

  // Helper functions for TTY-aware ANSI formatting using cli package
  inline bool is_dynamic_tty() {
    try {
      Rcpp::Environment cli = Rcpp::Environment::namespace_env("cli");
      Rcpp::Function is_dynamic_tty_fn = cli["is_dynamic_tty"];
      Rcpp::LogicalVector result = is_dynamic_tty_fn();
      return result[0];
    } catch (...) {
      // Fallback to false if cli package is not available
      return false;
    }
  }
  
  inline std::string ansi_bold_start() {
    return is_dynamic_tty() ? "\033[1m" : "";
  }
  
  inline std::string ansi_bold_end() {
    return is_dynamic_tty() ? "\033[22m" : "";
  }
  
  inline std::string ansi_green_start() {
    return is_dynamic_tty() ? "\033[32m" : "";
  }
  
  inline std::string ansi_reset() {
    return is_dynamic_tty() ? "\033[0m" : "";
  }

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
      
      // Line number with padding
      ss << std::setw(padding) << line_num << " | ";
      
      // Check if expression starts after the beginning of the line
      iter expr_start_on_line = std::max(expr_start, line_start);
      
      // Always show the full line content with bold formatting for the expression part
      if (expr_start_on_line > line_start) {
        // Show prefix, then bold expression, then suffix
        ss << std::string(line_start, expr_start_on_line);
        ss << ansi_bold_start() << std::string(expr_start_on_line, std::min(line_end, expr_end)) << ansi_bold_end();
        if (expr_end < line_end) {
          ss << std::string(expr_end, line_end);
        }
      } else {
        // Entire line or expression starts at line start
        iter expr_end_on_line = std::min(line_end, expr_end);
        ss << ansi_bold_start() << std::string(line_start, expr_end_on_line) << ansi_bold_end();
        if (expr_end_on_line < line_end) {
          ss << std::string(expr_end_on_line, line_end);
        }
      }
      ss << "\n";
      
      // Only show error indicators on the final line
      if (is_final_line) {
        // Error indicator line
        ss << std::string(padding + 3, ' ');
        
        // Calculate position for error indicator with green color
        bool in_green = false;
        iter expr_start_on_line_bounded = std::max(line_start, expr_start);
        iter expr_end_on_line_bounded = std::min(line_end, expr_end);
        
        for (iter j = line_start; j != line_end; ++j) {
          char new_cur = ' ';
          if (j == error_pos) {
            new_cur = '^';
          } else if (j >= expr_start_on_line_bounded && j < expr_end_on_line_bounded) {
            new_cur = '~';
          }
          
          if (new_cur != ' ' && !in_green) {
            ss << ansi_green_start();  // Start green
            in_green = true;
          } else if (new_cur == ' ' && in_green) {
            ss << ansi_reset();   // End green
            in_green = false;
          }
          
          ss << new_cur;
        }
        
        if (error_pos == line_end) {
          if (!in_green) {
            ss << ansi_green_start();  // Start green
          }
          ss << '^';
          ss << ansi_reset();     // End green
        } else if (in_green) {
          ss << ansi_reset();     // End green if still active
        }
        
        ss << "\n";
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
