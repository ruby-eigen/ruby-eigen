namespace RubyEigen {

%define DefineIntegerMatrix(T)
template<>
class Matrix<T, RubyEigen::Dynamic, RubyEigen::Dynamic> {
public:

  typedef T Scalar;

  Matrix(size_t, size_t);
  ~Matrix();

  %rename("dot") operator*;
  Matrix operator*(const Matrix&);

};
%enddef

DefineIntegerMatrix(int32_t)
DefineIntegerMatrix(int16_t)
DefineIntegerMatrix(int8_t)
DefineIntegerMatrix(uint32_t)
DefineIntegerMatrix(uint16_t)
DefineIntegerMatrix(uint8_t)

  %template(Int32Matrix) Matrix<int32_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(Int16Matrix) Matrix<int16_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(Int8Matrix)  Matrix<int8_t,  RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(UInt32Matrix) Matrix<uint32_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(UInt16Matrix) Matrix<uint16_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(UInt8Matrix)  Matrix<uint8_t,  RubyEigen::Dynamic, RubyEigen::Dynamic>;

  ExtendMatrixForNArray(int32_t)

};