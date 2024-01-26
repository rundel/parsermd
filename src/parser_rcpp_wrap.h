#ifndef PARSER_RCPP_WRAP_HPP
#define PARSER_RCPP_WRAP_HPP

#include "parse_option_ast.h"
#include "parse_chunk_ast.h"
#include "parse_code_block_ast.h"
#include "parse_rmd_ast.h"

#include <RcppCommon.h>

namespace Rcpp {
  // Chunk
  template <> SEXP wrap(client::ast::chunk const& chunk);
  template <> SEXP wrap(std::vector<client::ast::chunk> const& chunks);
  template <> SEXP wrap(std::vector<client::ast::option> const& opts);

  template <> SEXP wrap(client::ast::code_block const& block);

  // rmd
  template <> SEXP wrap(client::ast::heading const& h);
  template <> SEXP wrap(client::ast::element const& element);
  template <> SEXP wrap(client::ast::rmd const& rmd);
  template <> SEXP wrap(client::ast::yaml const& yaml);
  template <> SEXP wrap(client::ast::fdiv_open const& fdiv);
  template <> SEXP wrap(client::ast::fdiv_close const& fdiv);
  template <> SEXP wrap(client::ast::shortcode const& sc);
}

#endif
