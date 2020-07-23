#ifndef PARSE_PAREN_EXPR_HPP
#define PARSE_PAREN_EXPR_HPP

#include <boost/spirit/home/x3.hpp>

namespace client { namespace parser {

  namespace x3 = boost::spirit::x3;

  int n_br_open;
  struct _n_br_open{};

  auto init_paren = [](auto& ctx) {
    x3::get<_n_br_open>(ctx).get() = 0;
  };
  auto open_paren = [](auto& ctx) {
    x3::get<_n_br_open>(ctx).get()++;
  };
  auto close_paren = [](auto& ctx) {
    if (x3::get<_n_br_open>(ctx).get() == 0) {
      x3::_pass(ctx) = false;
    } else {
      x3::get<_n_br_open>(ctx).get()--;
    }
  };
  auto end_paren = [](auto& ctx) {
    if (x3::get<_n_br_open>(ctx).get() != 0) {
      x3::_pass(ctx) = false;
    }
  };

  // This needs to be complicated here because we want to allow our
  // expressions to contain brackets.
  //
  // Solution based on https://stackoverflow.com/questions/33624149/boost-spirit-x3-cannot-compile-repeat-directive-with-variable-factor/33627991#33627991
  // %= weirdness is from https://stackoverflow.com/questions/33929849/boost-spirit-x3-ast-not-working-with-semantic-actions-when-using-separate-rule-d/33937139#33937139
  //
  auto paren_expr = x3::rule<struct _, std::string> {}
                 %= x3::with<_n_br_open>(std::ref(n_br_open))
    [ (
        x3::eps[init_paren]  >>
        x3::raw[ x3::lexeme[
          *(   x3::char_('(')[open_paren]
            |  x3::char_(')')[close_paren]
            | ~x3::char_("()")
           )
        ] ] >>
        x3::eps[end_paren]
    ) ];
} }
#endif
