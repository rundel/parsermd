#ifndef PARSE_ERROR_HANDLER_HPP
#define PARSE_ERROR_HANDLER_HPP

#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/error_reporting.hpp>
#include <iomanip>
#include <Rcpp.h>

namespace client { namespace parser {

  namespace x3 = boost::spirit::x3;
  namespace ascii = boost::spirit::x3::ascii;

  // Cached TTY detection and ANSI formatting
  class ansi_formatter {
  private:
    static bool tty_checked;
    static bool use_ansi;
    
    static bool check_tty() {
      try {
        Rcpp::Environment cli = Rcpp::Environment::namespace_env("cli");
        Rcpp::Function is_dynamic_tty_fn = cli["is_dynamic_tty"];
        Rcpp::LogicalVector result = is_dynamic_tty_fn();
        return result[0];
      } catch (...) {
        return false;
      }
    }
    
  public:
    static bool should_use_ansi() {
      if (!tty_checked) {
        use_ansi = check_tty();
        tty_checked = true;
      }
      return use_ansi;
    }
    
    static std::string bold(const std::string& text) {
      return should_use_ansi() ? "\033[1m" + text + "\033[22m" : text;
    }
    
    static std::string green(const std::string& text) {
      return should_use_ansi() ? "\033[32m" + text + "\033[0m" : text;
    }
  };
  
  // Static member definitions
  bool ansi_formatter::tty_checked = false;
  bool ansi_formatter::use_ansi = false;
  
  // Line information for error reporting
  struct line_info {
    std::string content;
    int number;
    size_t start_offset;
    size_t end_offset;
  };

  template <typename iter>
  class error_message_builder {
  private:
    iter doc_start_, doc_end_, expr_start_, expr_end_, error_pos_;
    std::string expected_;
    
    int get_line_number(iter pos) const {
      return std::count(doc_start_, pos, '\n') + 1;
    }
    
    iter find_line_start(iter pos) const {
      return std::find(
        std::make_reverse_iterator(pos),
        std::make_reverse_iterator(doc_start_),
        '\n'
      ).base();
    }
    
    iter find_line_end(iter pos) const {
      return std::find(pos, doc_end_, '\n');
    }
    
    std::vector<line_info> extract_lines() const {
      int line_num_start = get_line_number(expr_start_);
      int line_num_end = get_line_number(error_pos_);
      
      // Ensure we have a valid range
      int start_line = std::min(line_num_start, line_num_end);
      int end_line = std::max(line_num_start, line_num_end);
      
      std::vector<line_info> lines;
      
      if (start_line == end_line) {
        // Single line case
        iter line_start = find_line_start(error_pos_);
        iter line_end = find_line_end(error_pos_);
        
        lines.push_back({
          std::string(line_start, line_end),
          end_line,
          static_cast<size_t>(line_start - doc_start_),
          static_cast<size_t>(line_end - doc_start_)
        });
      } else {
        // Multi-line case - start from the earlier position
        iter start_pos = (line_num_start <= line_num_end) ? expr_start_ : error_pos_;
        iter current_pos = find_line_start(start_pos);
        int current_line_num = start_line;
        
        while (current_line_num <= end_line) {
          iter line_end = find_line_end(current_pos);
          
          lines.push_back({
            std::string(current_pos, line_end),
            current_line_num,
            static_cast<size_t>(current_pos - doc_start_),
            static_cast<size_t>(line_end - doc_start_)
          });
          
          if (line_end == doc_end_ || current_line_num == end_line) {
            break;
          }
          
          current_pos = line_end + 1;
          current_line_num++;
        }
      }
      
      // Remove trailing empty lines to avoid showing unnecessary blank lines
      while (!lines.empty() && lines.back().content.empty()) {
        lines.pop_back();
      }
      
      return lines;
    }
    
    std::string format_line_content(const line_info& line, bool is_error_line) const {
      size_t expr_start_offset = static_cast<size_t>(expr_start_ - doc_start_);
      size_t expr_end_offset = static_cast<size_t>(expr_end_ - doc_start_);
      
      size_t expr_start_on_line = std::max(expr_start_offset, line.start_offset);
      size_t expr_end_on_line = std::min(expr_end_offset, line.end_offset);
      
      std::string result;
      
      // Prefix (before expression)
      if (expr_start_on_line > line.start_offset) {
        size_t prefix_len = expr_start_on_line - line.start_offset;
        result += line.content.substr(0, prefix_len);
      }
      
      // Expression part (bold)
      if (expr_end_on_line > expr_start_on_line) {
        size_t expr_start_in_line = expr_start_on_line - line.start_offset;
        size_t expr_len = expr_end_on_line - expr_start_on_line;
        std::string expr_text = line.content.substr(expr_start_in_line, expr_len);
        result += ansi_formatter::bold(expr_text);
      }
      
      // Suffix (after expression)
      if (expr_end_on_line < line.end_offset) {
        size_t suffix_start = expr_end_on_line - line.start_offset;
        result += line.content.substr(suffix_start);
      }
      
      return result;
    }
    
    std::string format_error_indicators(const line_info& line) const {
      size_t error_offset = static_cast<size_t>(error_pos_ - doc_start_);
      size_t expr_start_offset = static_cast<size_t>(expr_start_ - doc_start_);
      size_t expr_end_offset = static_cast<size_t>(expr_end_ - doc_start_);
      
      size_t expr_start_on_line = std::max(expr_start_offset, line.start_offset);
      size_t expr_end_on_line = std::min(expr_end_offset, line.end_offset);
      
      std::string indicators(line.content.length(), ' ');
      bool has_indicators = false;
      
      // Mark expression with tildes
      for (size_t i = expr_start_on_line; i < expr_end_on_line; ++i) {
        if (i >= line.start_offset && i < line.end_offset) {
          indicators[i - line.start_offset] = '~';
          has_indicators = true;
        }
      }
      
      // Mark error position with caret
      if (error_offset >= line.start_offset && error_offset < line.end_offset) {
        indicators[error_offset - line.start_offset] = '^';
        has_indicators = true;
      } else if (error_offset == line.end_offset) {
        indicators += '^';
        has_indicators = true;
      }
      
      // If no indicators were placed and this is the final line, add a caret at the end
      if (!has_indicators && line.content.empty()) {
        indicators = "^";
        has_indicators = true;
      }
      
      return ansi_formatter::green(indicators);
    }
    
  public:
    error_message_builder(iter error_pos, iter doc_start, iter doc_end, 
                          iter expr_start, iter expr_end, const std::string& expected)
      : doc_start_(doc_start), doc_end_(doc_end), expr_start_(expr_start), 
        expr_end_(expr_end), error_pos_(error_pos), expected_(expected) {
      if (error_pos_ == doc_end_) {
        error_pos_ = std::prev(error_pos_);
      }
    }
    
    std::string build_message() const {
      auto lines = extract_lines();
      if (lines.empty()) return "Parse error";
      
      std::stringstream ss;
      
      // Header message - use the actual lines being displayed
      if (lines.size() > 1) {
        ss << "Failed to parse lines " << lines.front().number << "-" << lines.back().number;
      } else if (lines.size() == 1) {
        ss << "Failed to parse line " << lines.back().number;
      } else {
        ss << "Parse error";
      }
      
      // Expected information
      if (!expected_.empty() && expected_.substr(0, 14) != "N5boost6spirit") {
        ss << ", expected " << expected_;
      }
      ss << "\n";
      
      // Calculate padding
      int max_line_num = lines.empty() ? 1 : lines.back().number;
      int padding = std::to_string(max_line_num).length();
      
      // Display lines
      int error_line_num = get_line_number(error_pos_);
      for (size_t i = 0; i < lines.size(); ++i) {
        const auto& line = lines[i];
        bool is_error_line = (line.number == error_line_num);
        
        // Line number and content
        ss << std::setw(padding) << line.number << " | ";
        ss << format_line_content(line, is_error_line) << "\n";
        
        // Error indicators on the line where the error occurred
        if (is_error_line) {
          ss << std::string(padding + 3, ' ');
          ss << format_error_indicators(line) << "\n";
        }
      }
      
      return ss.str();
    }
  };
  
  template <typename iter>
  void throw_parser_error(
      iter error_pos,
      iter doc_start, iter doc_end,
      iter expr_start, iter expr_end,
      std::string expected = ""
  ) {
    error_message_builder<iter> builder(error_pos, doc_start, doc_end, 
                                        expr_start, expr_end, expected);
    throw Rcpp::exception(builder.build_message().c_str(), false);
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
    
    template <typename T, typename Iterator, typename Context>
    void on_success(
      Iterator const& first, Iterator const& last, 
      T& ast, Context const& context
    ) {
        auto& error_handler = x3::get<x3::error_handler_tag>(context).get();
        error_handler.tag(ast, first, last);
    }
  };

  

} }

#endif
