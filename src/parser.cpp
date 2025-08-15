// [[Rcpp::plugins(cpp17)]]
// [[Rcpp::depends(BH)]]

//#define BOOST_SPIRIT_X3_DEBUG

#include <Rcpp.h>
#include <boost/format.hpp>
#include <algorithm>

#include "parser_error_handler.h"

#include "parse_cbrace.h"
#include "parse_rmd.h"
#include "parse_markdown.h"
#include "parse_shortcode.h"
#include "parse_inline_code.h"
#include "parse_span.h"
#include "parse_R_type.h"

#include "rcpp_wrap.h"

typedef boost::spirit::x3::error_handler<std::string::const_iterator> error_handler_type;

template <typename Parser, typename Attribute>
inline error_handler_type parse_str(
    std::string const& str,
    Parser const& p,
    Attribute& attr,
    bool use_expect = false
) {
  namespace x3 = boost::spirit::x3;

  auto iter = str.begin();
  auto const end = str.end();

  error_handler_type error_handler(iter, end, Rcpp::Rcout);
  auto const parser = x3::with<x3::error_handler_tag>(std::ref(error_handler))[ p ];

  bool r = x3::parse(iter, end, parser, attr);

  if (!r || iter != end) {
    client::parser::throw_parser_error(
      iter, str.begin(), str.end(), str.begin(), str.end()
    );
  }

  return error_handler;
}

// [[Rcpp::export]]
SEXP parse_shortcodes_cpp(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::vector<client::ast::shortcode> expr;
  auto error_handler = parse_str(str, client::parser::string_with_shortcodes, expr);

  // Using position tags find the position of the shortcodes
  for (auto& sc : expr) {
    auto pos = error_handler.position_of(sc);
    sc.start = pos.begin() - str.begin();
    sc.length = pos.end() - pos.begin();
  }

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
SEXP parse_inline_code_cpp(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::vector<client::ast::inline_code> expr;
  auto error_handler = parse_str(str, client::parser::string_with_inline_code, expr);

  for (auto& ic : expr) {
    auto pos = error_handler.position_of(ic);
    ic.start = pos.begin() - str.begin();
    ic.length = pos.end() - pos.begin();
    ic.braced = *(pos.begin()+1) == '{';
  }

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
SEXP parse_spans_cpp(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::vector<client::ast::span> expr;
  auto error_handler = parse_str(str, client::parser::string_with_span, expr);

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
SEXP parse_rmd_cpp(std::string const& str) {
  client::ast::rmd doc;
  parse_str(str, client::parser::rmd, doc);

  return Rcpp::wrap(doc);
}

// [[Rcpp::export]]
SEXP parse_R_value_cpp(std::string const& str) {
  client::ast::R_value expr;
  parse_str(str, client::parser::R_value, expr);

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
SEXP check_yaml_parser(std::string const& str) {
  client::ast::yaml expr;
  parse_str(str, client::parser::yaml, expr);

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
SEXP check_chunk_parser(std::string const& str) {
  client::ast::chunk expr;
  parse_str(str, client::parser::chunk, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
SEXP check_multi_chunk_parser(std::string const& str) {
  std::vector<client::ast::chunk> expr;
  parse_str(str, +client::parser::chunk, expr);

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
SEXP check_markdown_parser(std::string const& str) {
  client::ast::markdown expr;
  parse_str(str, client::parser::markdown, expr);

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
SEXP check_markdown_heading_parser(std::string const& str) {
  client::ast::heading expr;
  parse_str(str, client::parser::heading, expr);

  return Rcpp::wrap(expr);
}


// [[Rcpp::export]]
SEXP check_chunk_option_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::vector<client::ast::option> expr;
  auto const parser = x3::skip(x3::blank)[ client::parser::chunk_option % "," ];
  parse_str(str, parser, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
SEXP check_yaml_option_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::vector<std::string> expr;
  auto const parser = x3::skip(x3::blank)[ client::parser::yaml_option % x3::eol ];
  parse_str(str, parser, expr);

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
SEXP check_fdiv_open_parser(std::string const& str) {
  client::ast::fdiv_open expr;
  parse_str(str, client::parser::fdiv_open, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
SEXP check_fdiv_close_parser(std::string const& str) {
  client::ast::fdiv_close expr;
  parse_str(str, client::parser::fdiv_close, expr);

  return Rcpp::wrap(expr);
}




// [[Rcpp::export]]
SEXP check_cbrace_expr_parser(std::string const& str) {
  namespace x3 = boost::spirit::x3;

  std::string expr;
  auto const parser = x3::skip(x3::blank)[ client::parser::cbrace_expr ];
  parse_str(str, parser, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
SEXP check_code_block_parser(std::string const& str) {
  client::ast::code_block expr;
  parse_str(str, client::parser::code_block, expr);

  return Rcpp::wrap(expr);
}



// [[Rcpp::export]]
SEXP check_inline_code_parser(std::string const& str) {
  client::ast::inline_code expr;
  parse_str(str, client::parser::inline_code, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
SEXP check_shortcode_parser(std::string const& str) {
  client::ast::shortcode expr;
  parse_str(str, client::parser::shortcode, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
SEXP check_span_parser(std::string const& str) {
  client::ast::span expr;
  parse_str(str, client::parser::span, expr);

  return Rcpp::wrap(expr);
}

// [[Rcpp::export]]
SEXP check_qstring_parser(std::string const& str, bool raw = false) {
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
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("parsermd");
  Rcpp::Function rmd_code_block = pkg["rmd_code_block"];
  
  return rmd_code_block(
    Rcpp::Named("attr") = code_block.args.attr,
    Rcpp::Named("code") = code_block.code,
    Rcpp::Named("indent") = code_block.args.indent,
    Rcpp::Named("n_ticks") = code_block.args.n_ticks
  );
}


// chunk wrappers
template <> SEXP wrap(client::ast::chunk const& chunk) {
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("parsermd");

  // Pandoc raw attribute chunks get their own node class
  if (chunk.args.engine[0] == '=') {
    Rcpp::Function rmd_raw_chunk = pkg["rmd_raw_chunk"];
    
    return rmd_raw_chunk(
      Rcpp::Named("format") = chunk.args.engine.substr(1, chunk.args.engine.size()-1),
      Rcpp::Named("code") = chunk.code,
      Rcpp::Named("indent") = chunk.args.indent,
      Rcpp::Named("n_ticks") = chunk.args.n_ticks
    );
  }

  Rcpp::List options = Rcpp::wrap(chunk.args.chunk_options);

  Rcpp::CharacterVector yaml_options = Rcpp::wrap(chunk.yaml_options);
  
  Rcpp::Function parse_yaml = pkg["parse_yaml"];
  Rcpp::List parsed_yaml_options = parse_yaml(yaml_options);

  std::vector<std::string> yaml_names = Rcpp::as<std::vector<std::string>>(
    parsed_yaml_options.hasAttribute("names") 
    ? parsed_yaml_options.names()
    : Rcpp::CharacterVector()
  );

  Rcpp::CharacterVector option_names = options.hasAttribute("names")
    ? options.names()
    : Rcpp::CharacterVector();
  
  std::string conflicts = "";
  
  for (auto yaml_name : yaml_names) {
    
    std::string yaml_name_norm = yaml_name; // Normalize YAML option name 
    std::replace(yaml_name_norm.begin(), yaml_name_norm.end(), '-', '.');
    
    
    if (std::find(option_names.begin(), option_names.end(), yaml_name_norm) != option_names.end()) {
      if (conflicts != "") 
        conflicts += ", ";
      conflicts += yaml_name;
    }
    
    // Add YAML option using normalized name (overriding any conflicts)
    options[yaml_name_norm] = parsed_yaml_options[yaml_name];
  }

  // Warn about conflicts if any
  if (conflicts != "") {
    Rcpp::warning("YAML options override traditional options for: " + conflicts);
  }

  Rcpp::Function rmd_chunk = pkg["rmd_chunk"];
  return rmd_chunk(
    Rcpp::Named("engine") = chunk.args.engine,
    Rcpp::Named("name") = chunk.args.name,
    Rcpp::Named("options") = options,
    Rcpp::Named("code") = chunk.code,
    Rcpp::Named("indent") = chunk.args.indent,
    Rcpp::Named("n_ticks") = chunk.args.n_ticks
  );
};

template <> SEXP wrap(std::vector<client::ast::chunk> const& chunks){
  return Rcpp::List(chunks.begin(), chunks.end());
};

template <> SEXP wrap(std::vector<client::ast::option> const& opts) {
  Rcpp::List values;
  Rcpp::CharacterVector names;

  for(auto opt : opts) {
    SEXP R_val = parse_R_value_cpp(opt.value); 
    values.push_back(R_val);
    names.push_back(opt.name);
  }

  if (names.size() != 0) {
    values.attr("names") = names;
  }
  
  return values;
}



// rmd wrappers
template <> SEXP wrap(client::ast::heading const& h) {
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("parsermd");
  Rcpp::Function rmd_heading = pkg["rmd_heading"];
  
  return rmd_heading(
    Rcpp::Named("name") = h.name,
    Rcpp::Named("level") = h.level
  );
};


template <> SEXP wrap(client::ast::fdiv_open const& fdiv) {
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("parsermd");
  Rcpp::Function rmd_fenced_div_open = pkg["rmd_fenced_div_open"];
  
  // Extract ID (keep # prefix)
  std::string id_str = fdiv.attr.id;
  Rcpp::CharacterVector id_vec;
  if (!id_str.empty()) {
    id_vec = Rcpp::CharacterVector::create(id_str);
  }
  
  // Extract classes (keep . prefix)
  Rcpp::CharacterVector classes_vec;
  for (const auto& cls : fdiv.attr.classes) {
    classes_vec.push_back(cls);
  }
  
  // Extract key=value pairs into named vector
  Rcpp::CharacterVector attr_vec;
  Rcpp::CharacterVector attr_names;
  for (const auto& kv : fdiv.attr.kvs) {
    attr_vec.push_back(kv.value);
    attr_names.push_back(kv.key);
  }
  if (attr_vec.size() > 0) {
    attr_vec.names() = attr_names;
  }
  
  return rmd_fenced_div_open(
    Rcpp::Named("id") = id_vec,
    Rcpp::Named("classes") = classes_vec,
    Rcpp::Named("attr") = attr_vec
  );
}

template <> SEXP wrap(client::ast::fdiv_close const& fdiv) {
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("parsermd");
  Rcpp::Function rmd_fenced_div_close = pkg["rmd_fenced_div_close"];
  
  return rmd_fenced_div_close();
}


template <> SEXP wrap(client::ast::yaml const& x) {
  Rcpp::CharacterVector yaml = Rcpp::wrap(x.lines);
  
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("parsermd");
  Rcpp::Function parse_yaml = pkg["parse_yaml"];
  Rcpp::Function rmd_yaml = pkg["rmd_yaml"];

  return rmd_yaml(
    Rcpp::Named("yaml") = parse_yaml(yaml)
  );
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

template <> SEXP wrap(client::ast::R_type const& type) {
  struct line_visitor {
    SEXP operator()(bool x) { return Rcpp::wrap(x); }
    SEXP operator()(int  x) { return Rcpp::wrap(x); }
    SEXP operator()(double x) { return Rcpp::wrap(x); }
    SEXP operator()(std::string x) { return Rcpp::wrap(x); }
  } v;

  return boost::apply_visitor(v, type);
};

template <> SEXP wrap(client::ast::R_value const& value) {
  return Rcpp::wrap(value.x);
};


template <> SEXP wrap(client::ast::rmd const& rmd) {
  Rcpp::List nodes;
  for(auto const& element : rmd.elements) {
    nodes.push_back(Rcpp::wrap(element));
  }
  
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("parsermd");
  Rcpp::Function rmd_ast = pkg["rmd_ast"];
  return rmd_ast(Rcpp::Named("nodes") = nodes);
};


template <> SEXP wrap(client::ast::inline_code const& ic) {
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("parsermd");
  Rcpp::Function rmd_inline_code = pkg["rmd_inline_code"];
  
  return rmd_inline_code(
    Rcpp::Named("engine") = ic.engine,
    Rcpp::Named("code") = ic.code,
    Rcpp::Named("braced") = ic.braced,
    Rcpp::Named("start") = ic.start,
    Rcpp::Named("length") = ic.length
  );
};

template <> SEXP wrap(client::ast::shortcode const& sc) {
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("parsermd");
  Rcpp::Function rmd_shortcode = pkg["rmd_shortcode"];
  
  return rmd_shortcode(
    Rcpp::Named("func") = Rcpp::wrap(sc.func),
    Rcpp::Named("args") = Rcpp::wrap(sc.args),
    Rcpp::Named("start") = sc.start,
    Rcpp::Named("length") = sc.length
  );
};

template <> SEXP wrap(std::vector<client::ast::shortcode> const& v) {
  Rcpp::List res;
  for(auto const& sc : v) {
    res.push_back(Rcpp::wrap(sc));
  }

  return res;
};

template <> SEXP wrap(client::ast::span const& sp) {
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("parsermd");
  Rcpp::Function rmd_span = pkg["rmd_span"];
  
  // Extract ID (keep # prefix)
  std::string id_str = sp.attr.id;
  Rcpp::CharacterVector id_vec;
  if (!id_str.empty()) {
    id_vec = Rcpp::CharacterVector::create(id_str);
  }
  
  // Extract classes (keep . prefix)
  Rcpp::CharacterVector classes_vec;
  for (const auto& cls : sp.attr.classes) {
    classes_vec.push_back(cls);
  }
  
  // Extract key=value pairs into named vector
  Rcpp::CharacterVector attr_vec;
  Rcpp::CharacterVector attr_names;
  for (const auto& kv : sp.attr.kvs) {
    attr_vec.push_back(kv.value);
    attr_names.push_back(kv.key);
  }
  if (attr_vec.size() > 0) {
    attr_vec.names() = attr_names;
  }
  
  return rmd_span(
    Rcpp::Named("text") = sp.text,
    Rcpp::Named("id") = id_vec,
    Rcpp::Named("classes") = classes_vec,
    Rcpp::Named("attr") = attr_vec
  );
};

//template <> SEXP wrap(client::ast::md_element const& x) {
//  struct line_visitor {
//    SEXP operator()(client::ast::inline_code const& x) { return Rcpp::wrap(x); }
//    SEXP operator()(std::string const& x) { return Rcpp::wrap(x); }
//  } v;
//
//  return boost::apply_visitor(v, x);
//};

//template <> SEXP wrap(client::ast::md_line const& x) {
//  Rcpp::List res;
//  for(auto const& e : x.elements) {
//    res.push_back(Rcpp::wrap(e));
//  }
//  res.attr("class") = "rmd_markdown_line";
//
//  return res;
//}

template <> SEXP wrap(client::ast::markdown const& x) {
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("parsermd");
  Rcpp::Function rmd_markdown = pkg["rmd_markdown"];
  
  return rmd_markdown(
    Rcpp::Named("lines") = Rcpp::wrap(x.lines)
  );
}
}
