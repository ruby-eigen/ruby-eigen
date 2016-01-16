%module eigen

/* load macro */
%include "rb_error_handle.i"
%include "dense_matrix_vector_methods.i"
%include "dense_matrix_methods.i"
%include "dense_vector_methods.i"

%include std_string.i
%include std_vector.i
%include std_complex.i

%{

#define EIGEN_MPL2_ONLY 1

#include <strstream>
#include <Eigen/Core>
#include <Eigen/LU>
#include <Eigen/Eigenvalues>
#include <Eigen/QR>
#include <Eigen/SVD>
#include <Eigen/Cholesky>

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
  typedef Array<bool, Dynamic, Dynamic> ArrayBool;
  typedef Array<bool, Dynamic, 1> VecBoolCWise;

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

%template(StdVectorDouble__) std::vector<double>;
%template(StdVectorComplex__) std::vector< std::complex<double> >;

%include "matrix_double.i"
%include "matrix_complex.i"

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
  bool count();

  %extend{
    MatrixXd select(const MatrixXd &a, const MatrixXd &b) {
      return (*$self).select(a, b);
    }
  }
};

  // %include "array.i"

}; /* end of namespace ruby_eigen */

%include "decomposition.i"

