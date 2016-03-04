%module eigen

/* load macro */
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

/* To avoid contaminating Eigen namespace, we use RubyEigen instead of Eigen. */
namespace RubyEigen {
  using namespace Eigen;

  /*
     By redefining VectorXd and VectorXcd in SWIG scope, SWIG can interpret what the templates are.
     The following templates appear in some decomposition classes.
  */
  typedef RubyEigen::Matrix<RubyEigen::MatrixXd::Scalar, RubyEigen::Dynamic, 1> VectorXd;
  typedef RubyEigen::Matrix<RubyEigen::MatrixXcd::Scalar, RubyEigen::Dynamic, 1> VectorXcd;
  typedef RubyEigen::Matrix<RubyEigen::MatrixXi::Scalar, RubyEigen::Dynamic, 1> VectorXi;

  typedef RubyEigen::Block<RubyEigen::MatrixXd> MatrixDoubleRef;
  typedef RubyEigen::Block<RubyEigen::MatrixXcd> MatrixComplexRef;

  typedef Matrix<bool, Dynamic, Dynamic> MatrixBool;
  typedef Matrix<bool, Dynamic, 1> VectorBool;
  typedef Array<bool, Dynamic, Dynamic> CMatrixBool;
  typedef Array<bool, Dynamic, 1> CVectorBool;

  typedef SparseMatrix<double> SpMatrixDouble;
  typedef SparseMatrix<float>  SpMatrixFloat;
  typedef SparseMatrix<double>::InnerIterator SpMatrixDoubleIter;
  typedef SparseMatrix<float>::InnerIterator  SpMatrixFloatIter;

  typedef PermutationMatrix<RubyEigen::Dynamic, RubyEigen::Dynamic, int> PermutationMatrix;
  typedef Matrix<int, Dynamic, 1> PermutationIndices;

  typedef SparseQR<RubyEigen::SpMatrixDouble, COLAMDOrdering<int> > SparseQRDouble;
  typedef SparseQR<RubyEigen::SpMatrixFloat, COLAMDOrdering<int> > SparseQRFloat;

  typedef SparseLU<RubyEigen::SpMatrixDouble, COLAMDOrdering<int> > SparseLUDouble;
  typedef SparseLU<RubyEigen::SpMatrixFloat, COLAMDOrdering<int> > SparseLUFloat;

};

%} /* inline end */

/*
   The following code appears only in .cxx file. The specialization of template classes
   in SWIG context is done by using %template directive.
*/
%{
namespace RubyEigen {
  typedef FullPivLU<MatrixXd> FullPivLUDouble;
  typedef FullPivLU<MatrixXcd> FullPivLUComplex;
  typedef PartialPivLU<MatrixXd> PartialPivLUDouble;
  typedef FullPivHouseholderQR<MatrixXd> FullPivHouseholderQRDouble;
  typedef FullPivHouseholderQR<MatrixXcd> FullPivHouseholderQRComplex;
  typedef JacobiSVD<MatrixXd> JacobiSVDDouble;
  typedef JacobiSVD<MatrixXcd> JacobiSVDComplex;
  typedef LDLT<MatrixXd>  LDLTDouble;
  typedef LDLT<MatrixXcd> LDLTComplex;
  typedef LLT<MatrixXd>   LLTDouble;
  typedef LLT<MatrixXcd>  LLTComplex;
};
%}

%template(StdVectorInt__) std::vector<int>;
%template(StdVectorDouble__) std::vector<double>;
%template(StdVectorComplex__) std::vector< std::complex<double> >;

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

  DENSE_MATRIX_VECTOR_Common_Methods(VectorXd, MatrixXd, double)
  DENSE_VECTOR_Common_Methods(VectorXd, MatrixXd, double)

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

    MatrixXd select(const MatrixXd &a, const MatrixXd &b) {
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

%template(TransposeMatrixDouble) RubyEigen::Transpose<RubyEigen::MatrixXd>;


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

    RubyEigen::MatrixXd toMatrixDouble(){
      return (*$self);
    }

  }

};


%include "array.i"

}; /* end of namespace ruby_eigen */

%include "dense/decomposition.i"
