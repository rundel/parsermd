#include "parser_rcpp_wrap.h"

#include <Rcpp.h>

namespace Rcpp {
  // code block wrappers
  template <> SEXP wrap(client::ast::code_block const& code_block) {
    Rcpp::List res = Rcpp::List::create(
      Rcpp::Named("attr")  = code_block.args.attr,
      Rcpp::Named("code")    = code_block.code,
      Rcpp::Named("indent")  = code_block.args.indent,
      Rcpp::Named("n_ticks") = code_block.args.n_ticks
    );

    res.attr("class") = "rmd_code_block";

    return res;
  }

  // chunk wrappers
  template <> SEXP wrap(client::ast::chunk const& chunk) {

    // Pandoc raw attribute chunks get their own node class
    if (chunk.args.engine[0] == '=') {
      Rcpp::List res = Rcpp::List::create(
        Rcpp::Named("format")  = chunk.args.engine.substr(1, chunk.args.engine.size()-1),
        Rcpp::Named("code")    = chunk.code,
        Rcpp::Named("indent")  = chunk.args.indent,
        Rcpp::Named("n_ticks")  = chunk.args.n_ticks
      );

      res.attr("class") = "rmd_raw_chunk";

      return res;
    }

    Rcpp::List res = Rcpp::List::create(
      Rcpp::Named("engine")  = chunk.args.engine,
      Rcpp::Named("name")    = chunk.args.name,
      Rcpp::Named("options") = Rcpp::wrap(chunk.args.chunk_options),
      Rcpp::Named("yaml_options") = Rcpp::wrap(chunk.yaml_options),
      Rcpp::Named("code")    = chunk.code,
      Rcpp::Named("indent")  = chunk.args.indent,
      Rcpp::Named("n_ticks")  = chunk.args.n_ticks
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

  template <> SEXP wrap(client::ast::fdiv_open const& fdiv) {
    Rcpp::CharacterVector res = Rcpp::wrap(fdiv.attrs);
    res.attr("class") = "rmd_fenced_div_open";

    return res;
  }

  template <> SEXP wrap(client::ast::fdiv_close const& fdiv) {
    Rcpp::List res = Rcpp::List::create(
    );
    res.attr("class") = "rmd_fenced_div_close";

    return res;
  }

  template <> SEXP wrap(client::ast::yaml const& yaml) {
    Rcpp::CharacterVector res = Rcpp::wrap(yaml.lines);
    res.attr("class") = "rmd_yaml";

    return res;
  }

  template <> SEXP wrap(client::ast::element const& element) {
    struct line_visitor {
      SEXP operator()(client::ast::chunk const& x      ) { return Rcpp::wrap(x); }
      SEXP operator()(client::ast::code_block const& x ) { return Rcpp::wrap(x); }
      SEXP operator()(client::ast::yaml const& x       ) { return Rcpp::wrap(x); }
      SEXP operator()(client::ast::heading const& x    ) { return Rcpp::wrap(x); }
      SEXP operator()(client::ast::fdiv_open const& x  ) { return Rcpp::wrap(x); }
      SEXP operator()(client::ast::fdiv_close const& x ) { return Rcpp::wrap(x); }
      SEXP operator()(client::ast::markdown const& x   ) { return Rcpp::wrap(x); }
    } v;

    return boost::apply_visitor(v, element);
  };

  template <> SEXP wrap(client::ast::rmd const& rmd) {
    Rcpp::List res;
    for(auto const& element : rmd.elements) {
      res.push_back(Rcpp::wrap(element));
    }
    res.attr("class") = Rcpp::CharacterVector({"rmd_ast", "list"});

    return res;
  };

  template <> SEXP wrap(client::ast::shortcode const& sc) {
    Rcpp::List res = Rcpp::List::create(
      Rcpp::Named("func")  = Rcpp::wrap(sc.func),
      Rcpp::Named("args")  = Rcpp::wrap(sc.args)
    );
    res.attr("class") = "rmd_shortcode";

    return res;
  };


  template <> SEXP wrap(client::ast::inline_code const& ic) {
    Rcpp::List res = Rcpp::List::create(
      Rcpp::Named("engine")  = ic.engine,
      Rcpp::Named("code")    = ic.code
    );
    res.attr("class") = "rmd_inline_code";

    return res;
  };

  template <> SEXP wrap(client::ast::md_element const& x) {
    struct line_visitor {
      SEXP operator()(client::ast::inline_code const& x) { return Rcpp::wrap(x); }
      SEXP operator()(client::ast::shortcode const& x) { return Rcpp::wrap(x); }
      SEXP operator()(std::string const& x) { return Rcpp::wrap(x); }
    } v;

    return boost::apply_visitor(v, x);
  };

  template <> SEXP wrap(client::ast::md_line const& x) {
    Rcpp::List res;
    for(auto const& e : x.elements) {
      res.push_back(Rcpp::wrap(e));
    }
    res.attr("class") = "rmd_markdown_line";

    return res;
  }

  template <> SEXP wrap(client::ast::markdown const& x) {
    Rcpp::List res;
    for(auto const& l : x.lines) {
      res.push_back(Rcpp::wrap(l));
    }
    res.attr("class") = "rmd_markdown";

    return res;
  }

}
