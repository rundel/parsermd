#ifndef PARSE_CBRACE_HPP
#define PARSE_CBRACE_HPP

#include <boost/spirit/home/x3.hpp>

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  static int n_cbr_open;
  struct _n_cbr_open{};

  auto init_cbrace = [](auto& ctx) {
    x3::get<_n_cbr_open>(ctx).get() = 0;
  };
  auto open_cbrace = [](auto& ctx) {
    x3::get<_n_cbr_open>(ctx).get()++;
  };
  auto close_cbrace = [](auto& ctx) {
    if (x3::get<_n_cbr_open>(ctx).get() == 0) {
      x3::_pass(ctx) = false;
    } else {
      x3::get<_n_cbr_open>(ctx).get()--;
    }
  };
  auto end_cbrace = [](auto& ctx) {
    if (x3::get<_n_cbr_open>(ctx).get() != 0) {
      x3::_pass(ctx) = false;
    }
  };

  auto cbrace_expr = x3::rule<struct _, std::string> {}
  %= x3::with<_n_cbr_open>(std::ref(n_cbr_open))
    [ (
      x3::lexeme[
        x3::lit('{')[init_cbrace] >>
          x3::raw[
            *(  x3::char_('{')[open_cbrace]
            |  x3::char_('}')[close_cbrace]
            | ~x3::char_("{}") )
          ]
         >>
        x3::lit('}')[end_cbrace]
      ]
    ) ];
} }

#endif
