%module eigen

/* load macro */
%{
#include <stdexcept>
#include "rubyeigen_except.h"

%}

%include "rb_error_handle.i"

%include "dense/common_methods.i"
%include "dense/matrix_methods.i"
%include "dense/vector_methods.i"
%include "sparse/matrix_methods.i"

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
};
%}

%inline %{
namespace RubyEigen {
  typedef RubyEigen::Matrix<double, RubyEigen::Dynamic, RubyEigen::Dynamic> MatrixDouble;
  typedef RubyEigen::Matrix<float,  RubyEigen::Dynamic, RubyEigen::Dynamic> MatrixFloat;
  typedef RubyEigen::Matrix<std::complex<double>, RubyEigen::Dynamic, RubyEigen::Dynamic> MatrixDComplex;
  typedef RubyEigen::Matrix<std::complex<float>,  RubyEigen::Dynamic, RubyEigen::Dynamic> MatrixSComplex;

  typedef RubyEigen::Matrix<double, RubyEigen::Dynamic, 1> VectorXd;
  typedef RubyEigen::Matrix<float,  RubyEigen::Dynamic, 1> VectorXf;
  typedef RubyEigen::Matrix<std::complex<double>, RubyEigen::Dynamic, 1> VectorXcd;
  typedef RubyEigen::Matrix<std::complex<float>,  RubyEigen::Dynamic, 1> VectorXcf;
  typedef RubyEigen::Matrix<RubyEigen::MatrixXi::Scalar, RubyEigen::Dynamic, 1> VectorXi;

  typedef RubyEigen::Block<RubyEigen::MatrixDouble> MatrixDoubleRef;
  typedef RubyEigen::Block<RubyEigen::MatrixXcd> MatrixComplexRef;

  typedef Matrix<bool, Dynamic, Dynamic> MatrixBool;
  typedef Matrix<bool, Dynamic, 1> VectorBool;

  typedef SparseMatrix<double> SpMatrixDouble;
  typedef SparseMatrix<float>  SpMatrixFloat;
  typedef SparseMatrix<double>::InnerIterator SpMatrixDoubleIter;
  typedef SparseMatrix<float>::InnerIterator  SpMatrixFloatIter;

  typedef PermutationMatrix<RubyEigen::Dynamic, RubyEigen::Dynamic, int> PermutationMatrix;
  typedef Matrix<int, Dynamic, 1> PermutationIndices;

  template<class T> 
  struct rb_eigen_traits {
    typedef void vector_type;
    typedef void matrix_type;
    typedef T scalar_type;
  };

  template<>
  struct rb_eigen_traits<double> {
    typedef VectorXd vector_type;
    typedef MatrixDouble matrix_type;
  };

  template<>
  struct rb_eigen_traits<float> {
    typedef VectorXf vector_type;
    typedef MatrixFloat matrix_type;
  };

  template<>
  struct rb_eigen_traits<std::complex<double> > {
    typedef VectorXcd vector_type;
    typedef MatrixDComplex matrix_type;
  };

  template<>
  struct rb_eigen_traits<std::complex<float> > {
    typedef VectorXcf vector_type;
    typedef MatrixSComplex matrix_type;
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

/*
   The following code appears only in .cxx file. The specialization of template classes
   in SWIG context is done by using %template directive.
*/
%{
#include "rubyeigen_algo.h"
%}

%template() std::vector<int>;
%template() std::vector<double>;
%template() std::vector<float>;
%template() std::vector< std::complex<double> >;

%include "dense/matrix_double.i"
%include "dense/matrix_complex.i"
%include "sparse/matrix_real.i"
 //%include "sparse/solver.i"

namespace RubyEigen {

%rename(VectorInt) VectorXi;
%rename(VectorDouble) VectorXd;
%rename(VectorComplex) VectorXcd;

class VectorXd {
public:
  VectorXd(int);
  ~VectorXd();

  RubyEigen::VectorXd real();

  DENSE_MATRIX_VECTOR_Common_Methods(VectorXd, double)
  DENSE_VECTOR_Common_Methods(VectorXd, MatrixDouble, double)

};


class VectorXcd {
public:
  VectorXcd(int);
  ~VectorXcd();

  /* complex matrix only */
  RubyEigen::VectorXd imag();

  RubyEigen::VectorXd real();

  DENSE_MATRIX_VECTOR_Common_Methods(VectorXcd, std::complex<double>)
  DENSE_VECTOR_Common_Methods(VectorXcd, MatrixXcd, std::complex<double>)

};


class MatrixBool {
public:
  MatrixBool(int, int);
  ~MatrixBool();

  bool all();
  bool any();
  int count();

  %extend{

    MatrixDouble select(const MatrixDouble &a, const MatrixDouble &b) {
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

%template(TransposeMatrixDouble) RubyEigen::Transpose<RubyEigen::MatrixDouble>;


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

    RubyEigen::MatrixDouble toMatrixDouble(){
      return (*$self);
    }

  }

};


}; /* end of namespace ruby_eigen */

// %include "dense/decomposition.i"


