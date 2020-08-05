#ifndef PARSE_MARKDOWN_HPP
#define PARSE_MARKDOWN_HPP

#include <boost/variant/apply_visitor.hpp>

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/variant.hpp>
#include <boost/fusion/include/adapt_struct.hpp>


namespace client { namespace ast {
  namespace x3 = boost::spirit::x3;

  struct heading {
    std::string name;
    int level;
  };

  struct line : x3::variant<heading, std::string> {
    using base_type::base_type;
    using base_type::operator=;
  };

  typedef std::vector<line> markdown;

} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::heading,
  name, level
)



#include <RcppCommon.h>

namespace Rcpp {
  template <> SEXP wrap(client::ast::heading const& h);
  template <> SEXP wrap(client::ast::line const& rmd);
  template <> SEXP wrap(client::ast::markdown const& md);
}

#include <Rcpp.h>

namespace Rcpp {

  template <> SEXP wrap(client::ast::heading const& h) {
    Rcpp::List res = Rcpp::List::create(
      Rcpp::Named("name")  = h.name,
      Rcpp::Named("level") = h.level
    );
    res.attr("class") = "rmd_md_heading";

    return res;
  };

  template <> SEXP wrap(client::ast::line const& line) {
    struct line_visitor {
      SEXP operator()(client::ast::heading const& h) { return Rcpp::wrap(h); }
      SEXP operator()(std::string const& s) {return Rcpp::wrap(s); }
    };

    line_visitor v;

    return boost::apply_visitor(v, line);
  };

  template <> SEXP wrap(client::ast::markdown const& md) {
    Rcpp::List res(md.begin(), md.end());

    return res;
  };
}


namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto const text = x3::rule<struct _, std::string>{"line"}
  = x3::raw[ x3::lexeme[
      !(x3::lit("```{") | x3::lit("---") | x3::lit("#")) >>
      *(x3::char_ - x3::eol)
    ] ] ;

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
  = headn(6) | headn(5) | headn(4) | headn(3) | headn(2) | headn(1);

  auto const markdown = x3::rule<struct _, client::ast::markdown>{"markdown"}
  = +( (heading | text) >> x3::eol );
} }

#endif
