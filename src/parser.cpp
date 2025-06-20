// [[Rcpp::plugins(cpp17)]]
// [[Rcpp::depends(BH)]]

// #define BOOST_SPIRIT_X3_DEBUG

#include <Rcpp.h>
#include <boost/format.hpp>

#include "parser_error_handler.h"

#include "parse_cbrace.h"
#include "parse_rmd.h"
#include "parse_markdown.h"

#include "rcpp_wrap.h"



template <typename Parser, typename Attribute>
inline void parse_str(
    std::string const& str,
    Parser const& p,
    Attribute& attr,
    bool use_expect = false
) {
  namespace x3 = boost::spirit::x3;

  auto iter = str.begin();
  auto const end = str.end();

  using error_handler_type = x3::error_handler<std::string::const_iterator>;
  error_handler_type error_handler(iter, end, Rcpp::Rcout);

  auto const parser = x3::with<x3::error_handler_tag>(std::ref(error_handler))[ p ];

  bool r = x3::parse(iter, end, parser, attr);

  //if () // fail if we did not get a full match
  //  Rcpp::stop("Failed to parse.");

  if (!r || iter != end) {
    client::parser::throw_parser_error(
      iter, str.begin(), str.end(), str.begin(), str.end()
    );
  }
}


// [[Rcpp::export]]
Rcpp::List parse_rmd_cpp(std::string const& str) {
  client::ast::rmd doc;
  parse_str(str, client::parser::rmd, doc);

  return Rcpp::wrap(doc);
}


// [[Rcpp::export]]
Rcpp::CharacterVector check_yaml_parser(std::string const& str) {
  client::ast::yaml expr;
  parse_str(str, client::parser::yaml, expr);

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
Rcpp::List check_chunk_parser(std::string const& str) {
  client::ast::chunk expr;
  parse_str(str, client::parser::chunk, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
Rcpp::List check_multi_chunk_parser(std::string const& str) {
  std::vector<client::ast::chunk> expr;
  parse_str(str, +client::parser::chunk, expr);

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
Rcpp::List check_markdown_parser(std::string const& str) {
  client::ast::markdown expr;
  parse_str(str, client::parser::markdown, expr);

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
Rcpp::List check_markdown_heading_parser(std::string const& str) {
  client::ast::heading expr;
  parse_str(str, client::parser::heading, expr);

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
Rcpp::List check_chunk_option_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::vector<client::ast::option> expr;
  auto const parser = x3::skip(x3::blank)[ client::parser::chunk_option % "," ];
  parse_str(str, parser, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
Rcpp::CharacterVector check_yaml_option_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::vector<std::string> expr;
  auto const parser = x3::skip(x3::blank)[ client::parser::yaml_option % x3::eol ];
  parse_str(str, parser, expr);

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
Rcpp::CharacterVector check_fdiv_open_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  client::ast::fdiv_open expr;
  //auto const parser = x3::skip(x3::blank)[  ];
  parse_str(str, client::parser::fdiv_open, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
Rcpp::List check_fdiv_close_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  client::ast::fdiv_close expr;
  //auto const parser = x3::skip(x3::blank)[  ];
  parse_str(str, client::parser::fdiv_close, expr);

  return Rcpp::wrap(expr);
}




// [[Rcpp::export]]
Rcpp::CharacterVector check_cbrace_expr_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::string expr;
  auto const parser = x3::skip(x3::blank)[ client::parser::cbrace_expr ];
  parse_str(str, parser, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
Rcpp::List check_code_block_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  client::ast::code_block expr;
  parse_str(str, client::parser::code_block, expr);

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
Rcpp::List check_shortcode_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  client::ast::shortcode expr;
  parse_str(str, client::parser::shortcode, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
Rcpp::List check_inline_code_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  client::ast::inline_code expr;
  parse_str(str, client::parser::inline_code, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
Rcpp::List check_md_line_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  client::ast::md_line expr;
  parse_str(str, client::parser::md_line, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
Rcpp::CharacterVector check_qstring_parser(std::string const& str, bool raw = false) {
  namespace x3 = boost::spirit::x3;

  std::string expr;
  if (raw)
    parse_str(str, x3::raw[ client::parser::q_string ], expr);
  else
    parse_str(str, client::parser::q_string, expr);

  return Rcpp::wrap(expr);
}


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
  res.attr("class") = "rmd_yaml_text";

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
