#ifndef PARSE_RMD_HPP
#define PARSE_RMD_HPP

#include <boost/variant/apply_visitor.hpp>

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/variant.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

#include "parse_yaml.hpp"
#include "parse_markdown.hpp"
#include "parse_chunk.hpp"

using cell = boost::spirit::x3::variant<client::ast::chunk, client::ast::markdown>;

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct cell : x3::variant<chunk, markdown> {
    using base_type::base_type;
    using base_type::operator=;
  };

  struct rmd {
    yaml front_matter;
    std::vector<cell> cells;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::rmd,
  front_matter, cells
)

#include <RcppCommon.h>

namespace Rcpp {
  template <> SEXP wrap(client::ast::rmd const& rmd);
  template <> SEXP wrap(client::ast::cell const& cell);
}

#include <Rcpp.h>

namespace Rcpp {
  template <> SEXP wrap(client::ast::cell const& cell) {

    struct cell_visitor {
      SEXP operator()(client::ast::chunk const& c) { return Rcpp::wrap(c); }
      SEXP operator()(client::ast::markdown const& m) { return Rcpp::wrap(m); }
    };
    cell_visitor v;

    return boost::apply_visitor(v, cell);
  };

  template <> SEXP wrap(client::ast::rmd const& rmd) {

    Rcpp::CharacterVector yaml = Rcpp::wrap(rmd.front_matter);
    yaml.attr("class") = "rmd_yaml";

    Rcpp::List res;
    res.push_back(yaml);
    for(auto const& cell : rmd.cells) {
      res.push_back(Rcpp::wrap(cell));
    }
    res.attr("class") = "rmd_ast";

    return res;
  };
}



namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto const entry = x3::rule<struct _, client::ast::cell>{"cell"}
  = chunk | markdown;

  auto const rmd = x3::rule<struct _, client::ast::rmd>{"rmd"}
  = -yaml >> *entry;
} }

#endif
