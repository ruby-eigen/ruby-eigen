namespace RubyEigen {

%define DefineIntegerMatrix(T)
template<>
class Matrix<T, RubyEigen::Dynamic, RubyEigen::Dynamic> {
public:

  typedef T Scalar;

  Matrix(size_t, size_t);
  ~Matrix();

  size_t cols();
  size_t rows();

  Matrix transpose();

  DefineMVCommonMethods(Matrix, T)

  %rename("dot") operator*;
  Matrix operator*(const Matrix&);
  rb_eigen_traits<T>::vector_type operator*(const rb_eigen_traits<T>::vector_type &);
  Matrix operator*(const T&);

  ExtendMatrixForNArray(T)

  %extend {

    T __getitem__(size_t i, size_t j) {
      return (*$self)(i, j);
    }

    void __setitem__(size_t i, size_t j, T c) {
      (*$self)(i, j) = c;
    }

  }

};
%enddef

DefineIntegerMatrix(int64_t)
DefineIntegerMatrix(int32_t)
DefineIntegerMatrix(int16_t)
DefineIntegerMatrix(int8_t)
DefineIntegerMatrix(uint64_t)
DefineIntegerMatrix(uint32_t)
DefineIntegerMatrix(uint16_t)
DefineIntegerMatrix(uint8_t)

   // max and min
  ExtendRealMatrixCwiseOp(int64_t)
  ExtendRealMatrixCwiseOp(int32_t)
  ExtendRealMatrixCwiseOp(int16_t)
  ExtendRealMatrixCwiseOp(int8_t)
  ExtendRealMatrixCwiseOp(uint64_t)
  ExtendRealMatrixCwiseOp(uint32_t)
  ExtendRealMatrixCwiseOp(uint16_t)
  ExtendRealMatrixCwiseOp(uint8_t)

  %template(Int64Matrix) Matrix<int64_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(Int32Matrix) Matrix<int32_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(Int16Matrix) Matrix<int16_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(Int8Matrix)  Matrix<int8_t,  RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(UInt64Matrix) Matrix<uint64_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(UInt32Matrix) Matrix<uint32_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(UInt16Matrix) Matrix<uint16_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(UInt8Matrix)  Matrix<uint8_t,  RubyEigen::Dynamic, RubyEigen::Dynamic>;

};
