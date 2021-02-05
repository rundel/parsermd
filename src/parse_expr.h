#ifndef PARSE_EXPR_HPP
#define PARSE_EXPR_HPP

#include <boost/spirit/home/x3.hpp>

#include "parse_qstring.h"

namespace client { namespace parser {

  static int n_br_open;
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
  // expressions to contain parens.
  //
  // Solution based on https://stackoverflow.com/questions/33624149/boost-spirit-x3-cannot-compile-repeat-directive-with-variable-factor/33627991#33627991
  // %= weirdness is from https://stackoverflow.com/questions/33929849/boost-spirit-x3-ast-not-working-with-semantic-actions-when-using-separate-rule-d/33937139#33937139
  //
  auto paren_expr = x3::rule<struct _, std::string> {}
                 %= x3::with<_n_br_open>(std::ref(n_br_open))
    [ (
      x3::raw[ x3::lexeme[
        x3::char_('(')[init_paren] >>
        *(   x3::char_('(')[open_paren]
          |  x3::char_(')')[close_paren]
          | ~x3::char_("()")
        ) >>
        x3::char_(')')[end_paren]
      ] ]
    ) ];

  // Handle possible operators with ='s in them
  struct op_equal_ : x3::symbols<std::string> {
    op_equal_() {
      add("==", "==")
         ("!=", "!=")
         ("<=", "<=")
         (">=", ">=");
    }
  } op_equal;

  auto disallowed_char = x3::rule<struct _, char> {"disallowed_char"}
  = ~x3::char_("()=,}");

  // TODO - handle case of {} in an expression

  auto const expr = x3::rule<struct _, std::string>{"R expression"}
    = x3::raw[
        +(  client::parser::q_string
          | client::parser::paren_expr
          | op_equal
          | disallowed_char
         )
    ];
} }

#endif
