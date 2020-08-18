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
    int level;
    std::string name;
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
  level, name
)

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::rmd,
  front_matter, lines
)


namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto const chunk_start = (*indent_pat >> x3::lit("```{") >> x3::omit[ *(~x3::char_("}")) ] >> "}" >> x3::eol);
  auto const heading_start = x3::lit("#");

  auto const text_line = x3::rule<struct _, std::string>{"text line"}
  = !(chunk_start | heading_start) >> x3::lexeme[ *(x3::char_ - x3::eol) ];

  auto const text = x3::rule<struct _, std::vector<std::string>>{"text"}
  = +(text_line >> x3::eol);


  //static auto headn = [](int n) {
  //  return (
  //    x3::lexeme[
  //      x3::repeat(n)["#"] >>
  //      -x3::lit(" ") >>
  //      x3::raw[ *(x3::char_ - x3::eol) ]
  //    ] >>
  //    x3::attr(n)
  //  );
  //};
  //
  //auto const heading = x3::rule<struct _, client::ast::heading>{"heading"}
  //= (headn(6) | headn(5) | headn(4) | headn(3) | headn(2) | headn(1)) >> x3::eol;

  auto heading_level = ([](auto& ctx) { _val(ctx).level =  _attr(ctx).size(); });
  auto heading_name = ([](auto& ctx) { _val(ctx).name = _attr(ctx); });

  auto const heading = x3::rule<struct _, client::ast::heading> {"heading"}
  = (x3::repeat(1,6)[x3::char_("#")])[ heading_level ] >>
    -x3::lit(" ") >>
    ( *(x3::char_ - x3::eol) )[ heading_name ] >>
    x3::eol;

  auto const entry = x3::rule<struct _, client::ast::line> {"line"}
  = (chunk | heading | text) >> *x3::eol;

  auto const rmd = x3::rule<struct _, client::ast::rmd> {"rmd"}
  = -(yaml >> *x3::eol) >> *entry;
} }

#endif
