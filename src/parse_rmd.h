#ifndef PARSE_RMD_HPP
#define PARSE_RMD_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>

#include "parse_rmd_ast.h"

#include "parse_fenced_div.h"
#include "parse_yaml.h"
#include "parse_indent.h"
#include "parse_chunk.h"
#include "parse_code_block.h"
#include "parse_markdown.h"

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  // Rmd stuff
  auto const element = x3::rule<struct _, client::ast::element> {"rmd element"}
  %= x3::with<_n_fdiv_open>(std::ref(n_fdiv_open))[
    (chunk | code_block | heading | yaml | fdiv_close[close_fdiv] | fdiv_open[open_fdiv] | markdown) >> *x3::eol
  ];

  x3::rule<struct rmd, client::ast::rmd> rmd {"rmd"};
  struct rmd_class : error_handler {};

  auto const rmd_def = x3::rule<rmd_class, client::ast::rmd> {"rmd"}
  %= x3::with<_n_fdiv_open>(std::ref(n_fdiv_open))[
     x3::eps[init_fdiv] >>
     *element >>
     x3::eps[end_fdiv]
  ];

  BOOST_SPIRIT_DEFINE(rmd);

} }

#endif
