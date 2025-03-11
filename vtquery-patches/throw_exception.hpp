#ifndef BOOST_THROW_EXCEPTION_HPP_INCLUDED
#define BOOST_THROW_EXCEPTION_HPP_INCLUDED

namespace boost
{
void throw_exception( std::exception const & e ){
    throw e;
};
}// namespace boost

#define BOOST_THROW_EXCEPTION(x) ::boost::throw_exception(x)

#endif // #ifndef BOOST_THROW_EXCEPTION_HPP_INCLUDED
