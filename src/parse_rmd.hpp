#ifndef PARSE_RMD_HPP
#define PARSE_RMD_HPP

#include <boost/variant/apply_visitor.hpp>

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/variant.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

#include "parse_yaml.hpp"
//#include "parse_markdown.hpp"
#include "parse_chunk.hpp"

namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct heading {
    std::string name;
    int level;
  };

  struct line : x3::variant<chunk, heading, std::vector<std::string>> {
    using base_type::base_type;
    using base_type::operator=;
  };

  struct rmd {
    yaml front_matter;
    std::vector<line> lines;
  };
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::heading,
  name, level
)

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::rmd,
  front_matter, lines
)

#include <RcppCommon.h>

namespace Rcpp {
  template <> SEXP wrap(client::ast::heading const& h);
  template <> SEXP wrap(client::ast::line const& line);
  template <> SEXP wrap(client::ast::rmd const& rmd);
}

#include <Rcpp.h>

namespace Rcpp {
  template <> SEXP wrap(client::ast::heading const& h) {
    Rcpp::List res = Rcpp::List::create(
      Rcpp::Named("name")  = h.name,
      Rcpp::Named("level") = h.level
    );
    res.attr("class") = "rmd_heading";

    return res;
  };

  template <> SEXP wrap(client::ast::line const& line) {
    struct line_visitor {
      SEXP operator()(client::ast::chunk const& c) { return Rcpp::wrap(c); }
      SEXP operator()(client::ast::heading const& h) { return Rcpp::wrap(h); }
      SEXP operator()(std::vector<std::string> const& s) {return Rcpp::wrap(s); }
    } v;

    return boost::apply_visitor(v, line);
  };

  template <> SEXP wrap(client::ast::rmd const& rmd) {

    Rcpp::CharacterVector yaml = Rcpp::wrap(rmd.front_matter);
    yaml.attr("class") = "rmd_yaml";

    Rcpp::List res;
    res.push_back(yaml);
    for(auto const& line : rmd.lines) {
      res.push_back(Rcpp::wrap(line));
    }
    res.attr("class") = "rmd_ast";

    return res;
  };
}



namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;



  auto const text_line = x3::rule<struct _, std::string>{"text line"}
  = x3::raw[ x3::lexeme[
      !(x3::lit("```{") | x3::lit("---") | x3::lit("#")) >>
      *(x3::char_ - x3::eol)
    ] ];

  auto const text = x3::rule<struct _, std::vector<std::string>>{"text"}
  = +(text_line >> x3::eol);

  static auto headn = [](int n) {
    return (
      x3::lexeme[
        x3::repeat(n)["#"] >>
        -x3::lit(" ") >>
        x3::raw[ *(x3::char_ - x3::eol) ]
      ] >>
      x3::attr(n)
    );
  };

  auto const heading = x3::rule<struct _, client::ast::heading>{"heading"}
  = (headn(6) | headn(5) | headn(4) | headn(3) | headn(2) | headn(1)) >> x3::eol;

  auto const entry = x3::rule<struct _, client::ast::line>{"line"}
  = chunk | heading | text;

  auto const rmd = x3::rule<struct _, client::ast::rmd>{"rmd"}
  = -yaml >> *entry;
} }

#endif
