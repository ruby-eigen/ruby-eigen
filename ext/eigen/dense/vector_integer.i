namespace RubyEigen {

%define DefineIntegerVector(T)
template<>
class Matrix<T, RubyEigen::Dynamic, 1> {
public:

  typedef T Scalar;

  Matrix(size_t, size_t);
  ~Matrix();

  %rename("dot") operator*;
  Matrix operator*(const Matrix&);

  ExtendVectorForNArray(T)

};
%enddef

DefineIntegerVector(int64_t)
DefineIntegerVector(int32_t)
DefineIntegerVector(int16_t)
DefineIntegerVector(int8_t)
DefineIntegerVector(uint64_t)
DefineIntegerVector(uint32_t)
DefineIntegerVector(uint16_t)
DefineIntegerVector(uint8_t)

  %template(Int64Vector) Matrix<int64_t, RubyEigen::Dynamic, 1>;
  %template(Int32Vector) Matrix<int32_t, RubyEigen::Dynamic, 1>;
  %template(Int16Vector) Matrix<int16_t, RubyEigen::Dynamic, 1>;
  %template(Int8Vector)  Matrix<int8_t,  RubyEigen::Dynamic, 1>;
  %template(UInt64Vector) Matrix<uint64_t, RubyEigen::Dynamic, 1>;
  %template(UInt32Vector) Matrix<uint32_t, RubyEigen::Dynamic, 1>;
  %template(UInt16Vector) Matrix<uint16_t, RubyEigen::Dynamic, 1>;
  %template(UInt8Vector)  Matrix<uint8_t,  RubyEigen::Dynamic, 1>;

};
