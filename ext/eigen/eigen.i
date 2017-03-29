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

/* The following code appears in .cxx file and is also parsed by SWIG. See SWIG.html#SWIG_nn20 */
%inline %{
/* to avoid SWIG warning */
namespace Eigen {};
namespace RubyEigen {
  using namespace Eigen;
};
%}

%{
#include "rubyeigen_base.h"
%}
%include "rubyeigen_base.h"

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

%template(StdVectorInt) std::vector<int>;
%template(StdVectorDouble) std::vector<double>;
%template(StdVectorFloat) std::vector<float>;
%template(StdVectorComplex) std::vector< std::complex<double> >;

%include "dense/matrix_double.i"
%include "dense/matrix_complex.i"
%include "sparse/matrix_real.i"
%include "sparse/solver.i"

namespace RubyEigen {

%rename(VectorInt) VectorXi;
%rename(VectorDouble) VectorXd;
%rename(VectorComplex) VectorXcd;

class VectorXd {
public:
  VectorXd(int);
  ~VectorXd();

  RubyEigen::VectorXd real();

  DENSE_MATRIX_VECTOR_Common_Methods(VectorXd, MatrixDouble, double)
  DENSE_VECTOR_Common_Methods(VectorXd, MatrixDouble, double)

};


class VectorXcd {
public:
  VectorXcd(int);
  ~VectorXcd();

  /* complex matrix only */
  RubyEigen::VectorXd imag();

  RubyEigen::VectorXd real();

  DENSE_MATRIX_VECTOR_Common_Methods(VectorXcd, MatrixXcd, std::complex<double>)
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


%include "array.i"

}; /* end of namespace ruby_eigen */

%include "dense/decomposition.i"
