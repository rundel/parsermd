#ifndef PARSE_FENCED_DIV_HPP
#define PARSE_FENCED_DIV_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/annotate_on_success.hpp>

#include <Rcpp.h>

#include "parser_error_handler.h"
#include "parse_fenced_div_ast.h"



namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  // These are a bit easier than chunks since the number of :::'s don't need to match
  // See - https://pandoc.org/chunkedhtml-demo/8.18-divs-and-spans.html
  //
  // Also indenting is not supported so we ignore that as well
  // - See https://github.com/jgm/pandoc/issues/7936

  struct fdiv_open_class : error_handler, x3::annotate_on_success {};
  x3::rule<fdiv_open_class, client::ast::fdiv_open> const fdiv_open = "fdiv_open";

  // For unbraced attributes add the css class decorator
  auto add_class = [](auto& ctx){
    //_val(ctx) += std::string(".") + _attr(ctx);
    //_val(ctx) = std::vector<std::string> std::string(".") + _attr(ctx) );
    _val(ctx).push_back( std::string(".") + _attr(ctx) );
  };
  auto unbraced_attr = x3::rule<struct _, std::vector<std::string> > ("unbraced attribute")
  = x3::lexeme[ (+(x3::char_ - x3::eol - x3::blank))[add_class] ];

  auto cbrace_attrs = x3::rule<struct _, std::vector<std::string> > ("braced attribute(s)")
  = x3::lit("{") > x3::lexeme[ +(x3::char_ - x3::char_("{} ")) % +x3::blank ] > x3::lit("}");


  auto const fdiv_open_def
  = x3::lexeme[x3::omit[ x3::repeat(3, x3::inf)[x3::char_(':')] ]] >
       x3::skip(x3::blank)[
        (cbrace_attrs | unbraced_attr) >>
        x3::omit[ *x3::char_(':') ]   // ignore any trailing :s on the opening line
       ] >
       x3::eol;

  BOOST_SPIRIT_DEFINE(fdiv_open);


  struct fdiv_close_class : error_handler, x3::annotate_on_success {};
  x3::rule<fdiv_close_class, client::ast::fdiv_close> const fdiv_close = "fdiv_close";

  auto const fdiv_close_def
  = x3::lexeme[ x3::omit[ x3::repeat(3, x3::inf)[x3::char_(':')] ] ] >> x3::eol;

  BOOST_SPIRIT_DEFINE(fdiv_close);

} }

#endif
