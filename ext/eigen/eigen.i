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

namespace RubyEigen {

%rename(MatrixDouble) MatrixXd; 
%rename(MatrixComplex) MatrixXcd;
%rename(VectorDouble) VectorXd;
%rename(VectorComplex) VectorXcd;

%alias MatrixXd::operator== "__eq__";
%alias MatrixXcd::operator== "__eq__";

class MatrixXd {
public:
  MatrixXd(int, int);
  ~MatrixXd();

  /* real matrix only */
  MatrixXd cwiseAbs();
  MatrixXd cwiseAbs2();

  MatrixXd cwiseMax(MatrixXd &m);
  MatrixXd cwiseMax(double);
  MatrixXd cwiseMin(MatrixXd &m);
  MatrixXd cwiseMin(double);

  double maxCoeff();
  double minCoeff();

  Eigen::ArrayXXd array();

  RubyEigen::MatrixXd real();

  DENSE_MATRIX_VECTOR_Common_Methods(MatrixXd, VectorXd, double)
  DENSE_MATRIX_Common_Methods(MatrixXd, VectorXd, double)

}; /* end class MatrixXd */

class MatrixXcd {
public:
  MatrixXcd(int, int);
  ~MatrixXcd();

  /* complex matrix only */
  RubyEigen::MatrixXd imag();

  RubyEigen::MatrixXd real();

  DENSE_MATRIX_VECTOR_Common_Methods(MatrixXcd, VectorXcd, std::complex<double>)
  DENSE_MATRIX_Common_Methods(MatrixXcd, VectorXcd, std::complex<double>)

};


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


%alias FullPivLU::permutationP "p";
%alias FullPivLU::permutationQ "q";

template<class T>
class FullPivLU {
public:
  FullPivLU();
  ~FullPivLU();

  T permutationP();
  T permutationQ();

  T solve(T &b);

  %extend {

    T u() {
      return (*$self).matrixLU().triangularView<Eigen::Upper>();
    }

    T l() {
      return (*$self).matrixLU().triangularView<Eigen::UnitLower>();
    }
  }
};


%template(FullPivLUDouble) RubyEigen::FullPivLU<RubyEigen::MatrixXd>;
%template(FullPivLUComplex) RubyEigen::FullPivLU<RubyEigen::MatrixXcd>;

template<class T>
class PartialPivLU {
public:
  PartialPivLU();
  ~PartialPivLU();
};

%template(PartialPivLUDouble) RubyEigen::PartialPivLU<RubyEigen::MatrixXd>;
%template(PartialPivLUComplex) RubyEigen::PartialPivLU<RubyEigen::MatrixXcd>;


%alias FullPivHouseholderQR::matrixQ "q";
%alias FullPivHouseholderQR::colsPermutation "p";

template<class T>
class FullPivHouseholderQR {
public:
  FullPivHouseholderQR();
  ~FullPivHouseholderQR();

  T colsPermutation();
  T matrixQ();

  %extend {

    T r() {
      return (*$self).matrixQR().triangularView<Eigen::Upper>();
    }

  }
};

%template(FullPivHouseholderQRDouble) RubyEigen::FullPivHouseholderQR<RubyEigen::MatrixXd>;
%template(FullPivHouseholderQRComplex) RubyEigen::FullPivHouseholderQR<RubyEigen::MatrixXcd>;


template<class T>
class JacobiSVD {
public:
  JacobiSVD();
  ~JacobiSVD();

  T matrixU();
  T matrixV();

  VectorXd singularValues();

  T solve(VectorXd& m);
};

%template(JacobiSVDDouble) RubyEigen::JacobiSVD<RubyEigen::MatrixXd>;
%template(JacobiSVDComplex) RubyEigen::JacobiSVD<RubyEigen::MatrixXcd>;


template<class T>
class LDLT {
public:
  LDLT();
  ~LDLT();

  T matrixL();
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> vectorD();

};

%template(LDLTDouble) RubyEigen::LDLT<RubyEigen::MatrixXd>;
%template(LDLTComplex) RubyEigen::LDLT<RubyEigen::MatrixXcd>;


template<class T>
class LLT {
public:
  LLT();
  ~LLT();

  T matrixL();

};

%template(LLTDouble) RubyEigen::LLT<RubyEigen::MatrixXd>;
%template(LLTComplex) RubyEigen::LLT<RubyEigen::MatrixXcd>;

%include "array.i"


}; /* end of namespace ruby_eigen */

