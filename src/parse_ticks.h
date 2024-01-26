#ifndef PARSE_TICKS_HPP
#define PARSE_TICKS_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>

#include "parse_indent.h"

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  static int n_ticks;
  struct _n_ticks{};

  auto count_ticks = [](auto& ctx) {
    x3::get<_n_ticks>(ctx).get() =  x3::_attr(ctx).size();
    x3::_val(ctx) = x3::_attr(ctx).size();
  };
  auto match_ticks = [](auto& ctx) {
    x3::_pass(ctx) = ( x3::_attr(ctx).size() == x3::get<_n_ticks>(ctx).get() );
  };

  auto const open_ticks = x3::rule<struct _, int> {"open ticks"}
  = x3::with<_n_ticks>(std::ref(n_ticks)) [
      x3::repeat(3, x3::inf)[ x3::char_("`") ][count_ticks]
    ];

  auto const close_ticks = x3::rule<struct _, int> {"close ticks"}
  = x3::with<_n_ticks>(std::ref(n_ticks)) [
      x3::repeat(3, x3::inf)[ x3::char_("`") ][match_ticks]
  ];

  auto const code_line = x3::rule<struct _, std::string, true> {"code line"}
  = x3::raw[
      !( *indent_pat >> close_ticks ) >>
      *(x3::char_ - x3::eol)
    ][check_indent];

  auto const code_lines = x3::rule<struct _, std::vector<std::string>> {"lines of code"}
  = x3::lexeme[ *(
      x3::eol >> x3::attr(std::string()) // Handles the case of a blank line w/in indented code block / chunk
      | code_line > x3::eol)
  ];


} }

#endif
