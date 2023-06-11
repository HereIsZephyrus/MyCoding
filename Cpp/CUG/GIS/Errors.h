#pragma once
#ifndef _ERRORS_H_
#define _ERRORS_H_
#include<exception>
#include<iomanip>
#include<iostream>
namespace std_errors {
	using std::logic_error;
	using std::runtime_error;
	using std::domain_error;
	using std::invalid_argument;
	using std::bad_exception;
	using std::range_error;
}
using namespace std_errors;

class FileError : public runtime_error
{

};
class EdgeError : public range_error
{

};
class CreateError : public logic_error
{

};
class MoveError : public EdgeError {

};
class SetError : public invalid_argument
{

};

#endif // !_ERRORS_H_
