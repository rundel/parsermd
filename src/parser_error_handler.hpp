#ifndef PARSE_ERROR_HANDLER_HPP
#define PARSE_ERROR_HANDLER_HPP

#include <boost/spirit/home/x3.hpp>
#include <boost/spirit/home/x3/support/utility/error_reporting.hpp>

#include <Rcpp.h>

#include <type_traits>
#include <typeinfo>
#include <memory>
#include <string>
#include <cstdlib>

template <class T>
std::string type_name() {
  typedef typename std::remove_reference<T>::type TR;
  std::unique_ptr<char, void(*)(void*)> own(
      abi::__cxa_demangle(typeid(TR).name(), nullptr, nullptr, nullptr),
      std::free
  );

  std::string r = own != nullptr ? own.get() : typeid(TR).name();
  if (std::is_const<TR>::value)
    r += " const";
  if (std::is_volatile<TR>::value)
    r += " volatile";
  if (std::is_lvalue_reference<T>::value)
    r += "&";
  else if (std::is_rvalue_reference<T>::value)
    r += "&&";
  return r;
}



namespace client { namespace parser {

  namespace x3 = boost::spirit::x3;
  namespace ascii = boost::spirit::x3::ascii;

  struct error_handler {
    template <typename Iterator, typename Exception, typename Context>
    x3::error_handler_result on_error(
      Iterator& first, Iterator const& last,
      Exception const& x, Context const& context
    ) {
      auto& error_handler = x3::get<x3::error_handler_tag>(context).get();
      std::string message = "Error! Expecting: " + type_name<decltype(x.which())>();
      //error_handler(x.where(), message);

      //Rcpp::Rcout << "which: " << type_name<decltype(x.which())>() << "\n";
      //Rcpp::Rcout << "where: " << type_name<decltype(x.where())>() << "\n";
      //Rcpp::Rcout << "context: " << type_name<decltype(context)>() << "\n";
      //Rcpp::Rcout << "x: " << type_name<decltype(x)>() << "\n";

      Iterator f = error_handler.get_position_cache().first();
      Iterator l = error_handler.get_position_cache().last();

      //Rcpp::Rcout << "pos_cache: " << std::quoted( std::string(f, l) ) << "\n";
      //Rcpp::Rcout << "args: " << std::string(first, last) << "\n";

      auto cur_line_start = std::find(
        std::make_reverse_iterator(x.where()), std::make_reverse_iterator(first), '\n'
      ).base();
      auto cur_line_end = std::find(x.where(), last, '\n');

      int line_num = std::count(first, x.where(), '\n');

      int start_space = std::distance(cur_line_start, x.where());
      int end_space = std::max( (int) 0, (int) std::distance(x.where(), cur_line_end) - 1);
      int n = std::distance(cur_line_start, cur_line_end);

      //Rcpp::Rcout << "Problem: \"" << *(x.where()) << *(std::next(x.where()))
      //            << *(std::next(std::next(x.where()))) << "\"\n";
      //Rcpp::Rcout << "Start: " << *cur_line_start << *(cur_line_start++) << "\n";
      //Rcpp::Rcout << "Size: " << n << ", " << start_space << ", " << end_space << "\n";

      Rcpp::Rcout << "Error parsing line " << line_num + 1
                  << ", expected "
                  << abi::__cxa_demangle( x.which().c_str(), nullptr, nullptr, nullptr) << "\n";
                  //<< x.which() << "\n";
      Rcpp::Rcout << std::string(cur_line_start, cur_line_end) << "\n";

      if (start_space != 0)
        Rcpp::Rcout << std::setfill('~') << std::setw(start_space) << "";

      Rcpp::Rcout << "^";

      if (end_space != 0)
        Rcpp::Rcout << std::setfill('~') << std::setw(end_space) << "";

      Rcpp::Rcout << "\n";

      //Rcpp::Rcout << "2: " << std::string( first, cur_line_end) << "\n";
      //Rcpp::Rcout << "3: " << std::string( cur_line_start.base(), last) << "\n";

      //Rcpp::Rcout << "test: " << first == f << " & " << last == l << "\n";

      return x3::error_handler_result::fail;
    }
  };

} }

#endif
