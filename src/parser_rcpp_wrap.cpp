#include "parser_rcpp_wrap.h"

#include <Rcpp.h>

namespace Rcpp {
  // chunk wrappers
  template <> SEXP wrap(client::ast::chunk const& chunk) {
    Rcpp::List res = Rcpp::List::create(
      Rcpp::Named("engine")  = chunk.args.engine,
      Rcpp::Named("name")    = chunk.args.name,
      Rcpp::Named("options") = Rcpp::wrap(chunk.args.options),
      Rcpp::Named("code")    = chunk.code,
      Rcpp::Named("indent")  = chunk.args.indent
    );

    res.attr("class") = "rmd_chunk";

    return res;
  };

  template <> SEXP wrap(std::vector<client::ast::chunk> const& chunks){
    return Rcpp::List(chunks.begin(), chunks.end());
  };

  template <> SEXP wrap(std::vector<client::ast::option> const& opts) {
    Rcpp::List values;
    Rcpp::CharacterVector names;

    for(auto opt : opts) {
      values.push_back(opt.value);
      names.push_back(opt.name);
    }

    values.attr("names") = names;

    return values;
  }



  // rmd wrappers
  template <> SEXP wrap(client::ast::heading const& h) {
    Rcpp::List res = Rcpp::List::create(
      Rcpp::Named("name")  = h.name,
      Rcpp::Named("level") = h.level
    );
    res.attr("class") = "rmd_heading";

    return res;
  };

  template <> SEXP wrap(client::ast::element const& element) {
    struct line_visitor {
      SEXP operator()(client::ast::chunk const& c) { return Rcpp::wrap(c); }
      SEXP operator()(client::ast::heading const& h) { return Rcpp::wrap(h); }
      SEXP operator()(std::vector<std::string> const& s) {
        Rcpp::CharacterVector res = Rcpp::wrap(s);
        res.attr("class") = "rmd_markdown";
        return res;
      }
    } v;

    return boost::apply_visitor(v, element);
  };

  template <> SEXP wrap(client::ast::yaml const& yaml) {
    Rcpp::CharacterVector res = Rcpp::wrap(yaml.lines);
    res.attr("class") = "rmd_yaml";

    return res;
  }


  template <> SEXP wrap(client::ast::rmd const& rmd) {
    Rcpp::CharacterVector yaml = Rcpp::wrap(rmd.front_matter);

    Rcpp::List res;
    res.push_back(yaml);
    for(auto const& element : rmd.elements) {
      res.push_back(Rcpp::wrap(element));
    }
    res.attr("class") = Rcpp::CharacterVector({"rmd_ast", "list"});

    return res;
  };
}
