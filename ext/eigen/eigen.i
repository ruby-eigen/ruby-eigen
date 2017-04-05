%module eigen

#pragma SWIG nowarn=401

%rename("%(utitle)s", %$ismember, %$isfunction) "";
%rename("%(utitle)s", %$ismember, %$isvariable) "";

%feature("autodoc", "3");

%{
#include <stdexcept>
#include "rubyeigen_except.h"
%}

%include "rb_error_handle.i"

%include "dense/common_methods.i"

%include std_string.i
%include std_vector.i
%include std_complex.i

%{
extern "C" {
#include <numo/narray.h>
}
#include <complex>
#include <strstream>
#include <Eigen/Core>
#include <Eigen/LU>
#include <Eigen/Eigenvalues>
#include <Eigen/QR>
#include <Eigen/SVD>
#include <Eigen/Cholesky>
#include <Eigen/SparseCore>
#include <Eigen/SparseCholesky>
#include <Eigen/SparseLU>
#include <Eigen/SparseQR>
#include <Eigen/IterativeLinearSolvers>
#include <Eigen/Sparse>

%}

%inline %{
namespace Eigen {};
namespace RubyEigen {
  using namespace Eigen;
};
%}

%{
namespace RubyEigen {
  template<typename T>
  struct narray_traits{
    static VALUE type() { return Qnil; }
  };

  template<>
  struct narray_traits<double>{
    static VALUE type() { return numo_cDFloat; }
  };

  template<>
  struct narray_traits<float>{
    static VALUE type() { return numo_cSFloat; }
  };

  template<>
  struct narray_traits<int64_t>{
    static VALUE type() { return numo_cInt64; }
  };

  template<>
  struct narray_traits<int32_t>{
    static VALUE type() { return numo_cInt32; }
  };

  template<>
  struct narray_traits<int16_t>{
    static VALUE type() { return numo_cInt16; }
  };

  template<>
  struct narray_traits<int8_t>{
    static VALUE type() { return numo_cInt8; }
  };

  template<>
  struct narray_traits<uint64_t>{
    static VALUE type() { return numo_cUInt64; }
  };

  template<>
  struct narray_traits<uint32_t>{
    static VALUE type() { return numo_cUInt32; }
  };

  template<>
  struct narray_traits<uint16_t>{
    static VALUE type() { return numo_cUInt16; }
  };

  template<>
  struct narray_traits<uint8_t>{
    static VALUE type() { return numo_cUInt8; }
  };

  static void adjust_memory_usage(ssize_t n) {
#ifdef HAVE_RB_GC_ADJUST_MEMORY_USAGE
    rb_gc_adjust_memory_usage(n);
#endif
  }

  template<class T>
  static void adjust_memory_usage(const Matrix<T, RubyEigen::Dynamic, RubyEigen::Dynamic>* m) {
    adjust_memory_usage(m->rows()*m->cols()*sizeof(T));
  }

  template<class T>
  static void adjust_memory_usage(const Matrix<T, RubyEigen::Dynamic, 1>* v) {
    adjust_memory_usage(v->size()*sizeof(T));
  }

}; // namespace RubyEigen
%}

%inline %{
namespace RubyEigen {
  typedef RubyEigen::Matrix<double, RubyEigen::Dynamic, RubyEigen::Dynamic> DFloatMatrix;
  typedef RubyEigen::Matrix<float,  RubyEigen::Dynamic, RubyEigen::Dynamic> SFloatMatrix;
  typedef RubyEigen::Matrix<std::complex<double>, RubyEigen::Dynamic, RubyEigen::Dynamic> DComplexMatrix;
  typedef RubyEigen::Matrix<std::complex<float>,  RubyEigen::Dynamic, RubyEigen::Dynamic> SComplexMatrix;
  typedef RubyEigen::Matrix<int64_t, RubyEigen::Dynamic, RubyEigen::Dynamic> Int64Matrix;
  typedef RubyEigen::Matrix<int32_t, RubyEigen::Dynamic, RubyEigen::Dynamic> Int32Matrix;
  typedef RubyEigen::Matrix<int16_t, RubyEigen::Dynamic, RubyEigen::Dynamic> Int16Matrix;
  typedef RubyEigen::Matrix<int8_t,  RubyEigen::Dynamic, RubyEigen::Dynamic> Int8Matrix;
  typedef RubyEigen::Matrix<uint64_t, RubyEigen::Dynamic, RubyEigen::Dynamic> UInt64Matrix;
  typedef RubyEigen::Matrix<uint32_t, RubyEigen::Dynamic, RubyEigen::Dynamic> UInt32Matrix;
  typedef RubyEigen::Matrix<uint16_t, RubyEigen::Dynamic, RubyEigen::Dynamic> UInt16Matrix;
  typedef RubyEigen::Matrix<uint8_t,  RubyEigen::Dynamic, RubyEigen::Dynamic> UInt8Matrix;

  typedef RubyEigen::Matrix<double, RubyEigen::Dynamic, 1> DFloatVector;
  typedef RubyEigen::Matrix<float,  RubyEigen::Dynamic, 1> SFloatVector;
  typedef RubyEigen::Matrix<std::complex<double>, RubyEigen::Dynamic, 1> DComplexVector;
  typedef RubyEigen::Matrix<std::complex<float>,  RubyEigen::Dynamic, 1> SComplexVector;
  typedef RubyEigen::Matrix<int64_t, RubyEigen::Dynamic, 1> Int64Vector;
  typedef RubyEigen::Matrix<int32_t, RubyEigen::Dynamic, 1> Int32Vector;
  typedef RubyEigen::Matrix<int16_t, RubyEigen::Dynamic, 1> Int16Vector;
  typedef RubyEigen::Matrix<int8_t,  RubyEigen::Dynamic, 1> Int8Vector;
  typedef RubyEigen::Matrix<uint64_t, RubyEigen::Dynamic, 1> UInt64Vector;
  typedef RubyEigen::Matrix<uint32_t, RubyEigen::Dynamic, 1> UInt32Vector;
  typedef RubyEigen::Matrix<uint16_t, RubyEigen::Dynamic, 1> UInt16Vector;
  typedef RubyEigen::Matrix<uint8_t,  RubyEigen::Dynamic, 1> UInt8Vector;

  typedef RubyEigen::Block<RubyEigen::DFloatMatrix> DFloatMatrixRef;
  typedef RubyEigen::Block<RubyEigen::DComplexMatrix> DComplexMatrixRef;

  typedef Matrix<bool, Dynamic, Dynamic> MatrixBool;
  typedef Matrix<bool, Dynamic, 1> VectorBool;

  typedef SparseMatrix<double> DFloatSpMatrix;
  typedef SparseMatrix<float>  SFloatSpMatrix;
  typedef SparseMatrix<double>::InnerIterator DFloatSpMatrixIter;
  typedef SparseMatrix<float>::InnerIterator  SFloatSpMatrixIter;

  typedef PermutationMatrix<RubyEigen::Dynamic, RubyEigen::Dynamic, int> PermutationMatrix;
  typedef Matrix<int, Dynamic, 1> PermutationIndices;

  template<class T> 
  struct rb_eigen_traits {
    typedef void vector_type;
    typedef void matrix_type;
    typedef T scalar_type;
    typedef void float_type;
  };

  template<>
  struct rb_eigen_traits<double> {
    typedef DFloatVector vector_type;
    typedef DFloatMatrix matrix_type;
    typedef double float_type;
  };

  template<>
  struct rb_eigen_traits<float> {
    typedef SFloatVector vector_type;
    typedef SFloatMatrix matrix_type;
    typedef float float_type;
  };

  template<>
  struct rb_eigen_traits<std::complex<double> > {
    typedef DComplexVector vector_type;
    typedef DComplexMatrix matrix_type;
    typedef double float_type;
  };

  template<>
  struct rb_eigen_traits<std::complex<float> > {
    typedef SComplexVector vector_type;
    typedef SComplexMatrix matrix_type;
    typedef float float_type;
  };

  template<>
  struct rb_eigen_traits<int64_t> {
    typedef Int64Vector vector_type;
    typedef Int64Matrix matrix_type;
  };

  template<>
  struct rb_eigen_traits<int32_t> {
    typedef Int32Vector vector_type;
    typedef Int32Matrix matrix_type;
  };

  template<>
  struct rb_eigen_traits<int16_t> {
    typedef Int16Vector vector_type;
    typedef Int16Matrix matrix_type;
  };

  template<>
  struct rb_eigen_traits<int8_t> {
    typedef Int8Vector vector_type;
    typedef Int8Matrix matrix_type;
  };

  template<>
  struct rb_eigen_traits<uint64_t> {
    typedef UInt64Vector vector_type;
    typedef UInt64Matrix matrix_type;
  };

  template<>
  struct rb_eigen_traits<uint32_t> {
    typedef UInt32Vector vector_type;
    typedef UInt32Matrix matrix_type;
  };

  template<>
  struct rb_eigen_traits<uint16_t> {
    typedef UInt16Vector vector_type;
    typedef UInt16Matrix matrix_type;
  };

  template<>
  struct rb_eigen_traits<uint8_t> {
    typedef UInt8Vector vector_type;
    typedef UInt8Matrix matrix_type;
  };
}; // namespace RubyEigen
%}

%template() RubyEigen::rb_eigen_traits<double>;
%template() RubyEigen::rb_eigen_traits<float>;
%template() RubyEigen::rb_eigen_traits<std::complex<double>>;
%template() RubyEigen::rb_eigen_traits<std::complex<float>>;
%template() RubyEigen::rb_eigen_traits<int64_t>;
%template() RubyEigen::rb_eigen_traits<int32_t>;
%template() RubyEigen::rb_eigen_traits<int16_t>;
%template() RubyEigen::rb_eigen_traits<int8_t>;
%template() RubyEigen::rb_eigen_traits<uint64_t>;
%template() RubyEigen::rb_eigen_traits<uint32_t>;
%template() RubyEigen::rb_eigen_traits<uint16_t>;
%template() RubyEigen::rb_eigen_traits<uint8_t>;

typedef double RubyEigen::DFloatMatrix::Scalar;
typedef float  RubyEigen::SFloatMatrix::Scalar;
typedef std::complex<double> RubyEigen::DComplexMatrix::Scalar;
typedef std::complex<float>  RubyEigen::SComplexMatrix::Scalar;
typedef int64_t RubyEigen::Int64Matrix::Scalar;
typedef int32_t RubyEigen::Int32Matrix::Scalar;
typedef int16_t RubyEigen::Int16Matrix::Scalar;
typedef int8_t  RubyEigen::Int8Matrix::Scalar;
typedef uint64_t RubyEigen::UInt64Matrix::Scalar;
typedef uint32_t RubyEigen::UInt32Matrix::Scalar;
typedef uint16_t RubyEigen::UInt16Matrix::Scalar;
typedef uint8_t  RubyEigen::UInt8Matrix::Scalar;

%{
#include "rubyeigen_algo_base.h"
%}
%include "rubyeigen_algo_base.h"

%{
#include "rubyeigen_algo.h"
%}

%template() std::vector<int>;
%template() std::vector<double>;
%template() std::vector<float>;
%template() std::vector< std::complex<double> >;

%include "dense/extend_matrix.i"
%include "dense/extend_vector.i"
%include "dense/matrix_double.i"
%include "dense/matrix_integer.i"
%include "dense/vector_float.i"
%include "dense/vector_integer.i"
%include "sparse/matrix_real.i"
 //%include "sparse/solver.i"


namespace RubyEigen {

class MatrixBool {
public:
  MatrixBool(int, int);
  ~MatrixBool();

  bool all();
  bool any();
  int count();

  %extend{

    DFloatMatrix select(const DFloatMatrix &a, const DFloatMatrix &b) {
      return (*$self).select(a, b);
    }

  }
};

%nodefaultctor Transpose;
template<class T>
class Transpose {
public:

  T operator*(const T& m);

};

%template(TransposeMatrixDouble) RubyEigen::Transpose<RubyEigen::DFloatMatrix>;


class PermutationMatrix {
public:
  PermutationMatrix(size_t);

  size_t rows();
  size_t cols();

  int determinant();
  PermutationMatrix inverse();
  PermutationMatrix transpose();

  PermutationMatrix operator*(const PermutationMatrix&);

  %extend{

    std::vector<int> indices(){
      std::vector< int > v((*$self).rows());
      RubyEigen::PermutationIndices v0 = (*$self).indices();
      for(int i=0; i<v.size(); i++){
        v[i] = v0(i);
      }
      return v;
    }

    RubyEigen::DFloatMatrix toMatrixDouble(){
      return (*$self);
    }

  }

};


}; /* end of namespace ruby_eigen */

%include "dense/decomposition.i"


