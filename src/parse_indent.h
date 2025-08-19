#ifndef PARSE_INDENT_HPP
#define PARSE_INDENT_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  // Indent stuff

  // indent code based on https://stackoverflow.com/questions/62143841/spirit-x3-referring-to-a-previously-matched-value
  auto const indent_pat = x3::char_(" \t>");

  struct indent{};
  auto start_indent = x3::rule<struct _, std::string, true> {"start indent"}
  = (*indent_pat)
    [([](auto& ctx) {
      x3::get<indent>(ctx) = x3::_attr(ctx);
    })];

  auto end_indent = x3::rule<struct _, std::string, true> {"end indent"}
  = (*indent_pat)
    [([](auto& ctx) {
      x3::_pass(ctx) = (x3::get<indent>(ctx) == x3::_attr(ctx));
    })];

  auto check_indent = [](auto& ctx) {
    size_t n = x3::get<indent>(ctx).length();
    x3::_pass(ctx) = (x3::get<indent>(ctx) == x3::_attr(ctx).substr(0, n)); // Compare the indents
    x3::_attr(ctx).erase(0, n);                                             // erase the first n chars
    // so code line wont have indent
    x3::_val(ctx) = x3::_attr(ctx);
  };

  auto check_indent_blank = [](auto& ctx) {
    // A blank line may or may not have the proper indent - it may be missing or partial
    // we want to compare what we have

    size_t n_indent = x3::get<indent>(ctx).length();
    size_t n_input = x3::_attr(ctx).length();

    size_t n = n_indent > n_input ? n_input : n_indent; // Use the smaller of the two lengths

    x3::_pass(ctx) = (x3::get<indent>(ctx).substr(0,n) == x3::_attr(ctx).substr(0, n)); // Compare the indents
    x3::_attr(ctx).erase(0, n);                                             // erase the first n chars
    // so code line wont have indent
    x3::_val(ctx) = x3::_attr(ctx);
  };
} }

#endif
