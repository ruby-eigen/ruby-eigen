%module eigen

#pragma SWIG nowarn=401

%rename("%(utitle)s", %$ismember, %$isfunction) "";
%rename("%(utitle)s", %$ismember, %$isvariable) "";

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

  static void adjust_memory_usage(ssize_t n) {
#ifdef HAVE_RB_GC_ADJUST_MEMORY_USAGE
    rb_gc_adjust_memory_usage(n);
#endif
  }

};
%}

%inline %{
namespace RubyEigen {
  typedef RubyEigen::Matrix<double, RubyEigen::Dynamic, RubyEigen::Dynamic> DFloatMatrix;
  typedef RubyEigen::Matrix<float,  RubyEigen::Dynamic, RubyEigen::Dynamic> SFloatMatrix;
  typedef RubyEigen::Matrix<std::complex<double>, RubyEigen::Dynamic, RubyEigen::Dynamic> DComplexMatrix;
  typedef RubyEigen::Matrix<std::complex<float>,  RubyEigen::Dynamic, RubyEigen::Dynamic> SComplexMatrix;

  typedef RubyEigen::Matrix<double, RubyEigen::Dynamic, 1> DFloatVector;
  typedef RubyEigen::Matrix<float,  RubyEigen::Dynamic, 1> SFloatVector;
  typedef RubyEigen::Matrix<std::complex<double>, RubyEigen::Dynamic, 1> DComplexVector;
  typedef RubyEigen::Matrix<std::complex<float>,  RubyEigen::Dynamic, 1> SComplexVector;
  typedef RubyEigen::Matrix<RubyEigen::MatrixXi::Scalar, RubyEigen::Dynamic, 1> VectorXi;

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

};
%}

%template() RubyEigen::rb_eigen_traits<double>;
%template() RubyEigen::rb_eigen_traits<float>;
%template() RubyEigen::rb_eigen_traits<std::complex<double>>;
%template() RubyEigen::rb_eigen_traits<std::complex<float>>;

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

%include "dense/matrix_double.i"
%include "dense/vector_float.i"
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


