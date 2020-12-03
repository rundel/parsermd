#ifndef PARSER_RCPP_WRAP_HPP
#define PARSER_RCPP_WRAP_HPP

#include "parse_option_ast.hpp"
#include "parse_chunk_ast.hpp"
#include "parse_rmd_ast.hpp"


#include <RcppCommon.h>

namespace Rcpp {
  // Chunk
  template <> SEXP wrap(client::ast::chunk const& chunk);
  template <> SEXP wrap(std::vector<client::ast::chunk> const& chunks);
  template <> SEXP wrap(std::vector<client::ast::option> const& opts);

  // rmd
  template <> SEXP wrap(client::ast::heading const& h);
  template <> SEXP wrap(client::ast::element const& element);
  template <> SEXP wrap(client::ast::rmd const& rmd);
  template <> SEXP wrap(client::ast::yaml const& yaml);
}


#endif
