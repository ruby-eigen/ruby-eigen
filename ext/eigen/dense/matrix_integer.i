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

  ExtendMatrixForNArray(T)

  %extend {

    T __getitem__(int i, int j) {
      return (*$self)(i, j);
    }

    void __setitem__(int i, int j, T c) {
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
