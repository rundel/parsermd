#ifndef PARSE_CODE_BLOCK_HPP
#define PARSE_CODE_BLOCK_HPP

//#define BOOST_SPIRIT_X3_DEBUG
#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/ast/position_tagged.hpp>
#include <boost/fusion/include/adapt_struct.hpp>

#include "parser_error_handler.h"

#include "parse_indent.h"
#include "parse_chunk.h"

namespace client { namespace ast {
namespace x3 = boost::spirit::x3;

struct code_block : x3::position_tagged{
  std::string indent;
  std::string fence;
  std::string info;
  std::vector<std::string> code;
};
} }

BOOST_FUSION_ADAPT_STRUCT(
  client::ast::code_block,
  indent, fence, info, code
)

namespace client { namespace parser {
  namespace x3 = boost::spirit::x3;

  auto const fence_pat = x3::rule<struct _, std::string> {"fence"}
  = x3::repeat(3, x3::inf)[x3::char_('`')] |
    x3::repeat(3, x3::inf)[x3::char_('~')];

  struct fence{};

  auto start_fence = x3::rule<struct _, std::string, true> {"start fence"}
  = fence_pat[
      ([](auto& ctx) {
        x3::get<fence>(ctx) = x3::_attr(ctx);
      })
    ];

  auto end_fence = x3::rule<struct _, std::string, true> {"end fence"}
  = fence_pat[
      ([](auto& ctx) {
        x3::_pass(ctx) = (x3::get<fence>(ctx) == x3::_attr(ctx));
      })
    ];

  //auto const block_start = x3::rule<struct _, std::string> {"block start"}
  //=


  auto const block_end = x3::rule<struct _> {"block end"}
  = x3::lexeme[
      x3::expect[ x3::omit[ end_indent ] ] >>
      x3::expect[ x3::omit[ end_fence ] ]
    ];// >> *x3::lit(" ") >> x3::eol
    //| &x3::lexeme[ x3::omit[ end_indent ] >> x3::lit("```{") ];
  // Chunk can be ended by a new chunk starting see Yihui's book Sec 5.1.4
  // look ahead to match but not consume this new chun

  struct code_block_class : error_handler, x3::annotate_on_success {};
  x3::rule<code_block_class, client::ast::code_block> const code_block = "code_block";

  auto const code_block_def
    = x3::with<fence>(std::string()) [ x3::with<indent>(std::string()) [
      x3::lexeme[
        (start_indent >> start_fence >> *(x3::char_ - x3::eol)) >> x3::eol
      ] >>
      chunk_code >>
      x3::expect[block_end]
    ] ];

  BOOST_SPIRIT_DEFINE(code_block);

} }


#endif
