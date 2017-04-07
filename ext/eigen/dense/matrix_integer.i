namespace RubyEigen {

%define DefineIntegerMatrix(T)
template<>
class Matrix<T, RubyEigen::Dynamic, RubyEigen::Dynamic> {
public:

  typedef T Scalar;

  Matrix(size_t, size_t);
  ~Matrix();

%rename("has_nan") hasNaN;
  bool hasNaN();

  void setRandom();
  void setConstant(T);
  void setIdentity();
  void setOnes();
  void setZero();

  size_t cols();
  size_t rows();

  T sum();
  T prod();

  Matrix transpose();

  /* component wise op */

%rename("__mul__") cwiseProduct;
%rename("__div__") cwiseQuotient;
  Matrix cwiseProduct(const Matrix &m);
  Matrix cwiseQuotient(const Matrix &m);

  %rename("dot") operator*;
  Matrix operator*(const Matrix&);
  rb_eigen_traits<T>::vector_type operator*(const rb_eigen_traits<T>::vector_type &);
  Matrix operator*(const T&);

  Matrix operator+(const Matrix &m);
  Matrix operator-(const Matrix &m);
  Matrix operator-();
  Matrix operator/(const T d);

  bool operator==(Matrix &m);

  bool isOnes();
  bool isZero();

  Matrix adjoint();

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

  %template(Int64Matrix) Matrix<int64_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(Int32Matrix) Matrix<int32_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(Int16Matrix) Matrix<int16_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(Int8Matrix)  Matrix<int8_t,  RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(UInt64Matrix) Matrix<uint64_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(UInt32Matrix) Matrix<uint32_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(UInt16Matrix) Matrix<uint16_t, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(UInt8Matrix)  Matrix<uint8_t,  RubyEigen::Dynamic, RubyEigen::Dynamic>;

};
