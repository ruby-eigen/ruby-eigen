%module eigen

%include "rb_error_handle.i"

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

namespace RubyEigen {

%rename(MatrixDouble) MatrixXd; 
%rename(MatrixComplex) MatrixXcd;
%rename(VectorDouble) VectorXd;
%rename(VectorComplex) VectorXcd;

%alias MatrixXd::operator== "__eq__";

class MatrixXd {

public:
  MatrixXd(int, int);
  ~MatrixXd();

  Eigen::ArrayXXd array();

  RubyEigen::VectorXd col(int);
  RubyEigen::VectorXd row(int);

  int cols();
  int rows();

  //  bool allFinite();
  bool hasNaN();

  void setRandom();
  void setConstant(double);
  void setIdentity();
  void setOnes();
  void setZero();

  /* component wise op */
  MatrixXd cwiseAbs();
  MatrixXd cwiseAbs2();
  MatrixXd cwiseSqrt();
  MatrixXd cwiseInverse();

  MatrixXd cwiseProduct(MatrixXd &m);
  MatrixXd cwiseQuotient(MatrixXd &m);

  MatrixXd cwiseMax(MatrixXd &m);
  MatrixXd cwiseMax(double);
  MatrixXd cwiseMin(MatrixXd &m);
  MatrixXd cwiseMin(double);

  MatrixBool cwiseEqual(MatrixXd &m);
  MatrixBool cwiseEqual(double);
  MatrixBool cwiseNotEqual(MatrixXd &m);

  VectorXd diagonal();
  MatrixXd diagonal(int);

  MatrixXd inverse();
  double determinant();
  double norm();
  double operatorNorm();
  double maxCoeff();
  double minCoeff();

  double sum();
  double prod();

  void normalize();

  MatrixXd transpose();
  MatrixXd reverse();
  MatrixXd replicate(int, int);

  RubyEigen::VectorXcd eigenvalues();

  MatrixXd operator+(const MatrixXd &m);
  MatrixXd operator-(const MatrixXd &m);
  MatrixXd operator-();
  MatrixXd operator*(const MatrixXd &m);
  MatrixXd operator*(double d);
  MatrixXd operator/(double d);

  bool operator==(MatrixXd &m);
  bool isApprox(MatrixXd &m);
  bool isApprox(MatrixXd &m, double);
  bool isApproxToConstant(double);
  bool isConstant(double);

  bool isDiagonal();
  bool isIdentity();
  bool isLowerTriangular();
  bool isLowerTriangular(double);
  bool isUpperTriangular();
  bool isUpperTriangular(double);

  bool isMuchSmallerThan(double);
  bool isMuchSmallerThan(double, double);
  bool isMuchSmallerThan(MatrixXd& m);
  bool isMuchSmallerThan(MatrixXd& m, double);

  bool isOnes();
  bool isOnes(double);
  bool isZero();
  bool isZero(double);

  MatrixXd middleCols(int, int);
  MatrixXd middleRows(int, int);

  /*
    colwise
    rowwise

    imag
    real
  */

  RubyEigen::PartialPivLU<RubyEigen::MatrixXd> lu();

  RubyEigen::LDLT<RubyEigen::MatrixXd> ldlt();
  RubyEigen::LLT<RubyEigen::MatrixXd> llt();
  
  %extend {

    void __set_col__(int i, const std::vector<double> &v){
      (*self).col(i) = Eigen::VectorXd::Map(v.data(), v.size());
    }

    void __set_row__(int i, const std::vector<double> &v){
      (*self).row(i) = Eigen::VectorXd::Map(v.data(), v.size());
    }

    MatrixXd __mul_n__(MatrixXd &a, MatrixXd &b, MatrixXd &c, MatrixXd &d){
      return (*$self) * a * b * c * d;
    }

    std::string to_s() {
      std::ostrstream s;
      s << (*$self) << std::ends;
      return s.str();
    }

    double __getitem__(int i, int j) {
      return (*$self)(i, j);
    }

    void __setitem__(int i, int j, double c) {
      (*$self)(i, j) = c;
    }
 
    MatrixXd triu() {
      return (*$self).triangularView<Eigen::Upper>();
    }

    MatrixXd tril() {
      return (*$self).triangularView<Eigen::Lower>();
    }

    RubyEigen::FullPivLU<MatrixXd> fullPivLu() {
      return (*self).fullPivLu();
    }

    RubyEigen::FullPivHouseholderQR<MatrixXd> fullPivHouseholderQR() {
      return RubyEigen::FullPivHouseholderQR<RubyEigen::MatrixXd>(*$self);
    }

    RubyEigen::JacobiSVD<MatrixXd> svd() {
      return Eigen::JacobiSVD<Eigen::MatrixXd>(*$self, Eigen::ComputeFullU | Eigen::ComputeFullV);
    }
  }

}; /* end class MatrixXd */

class VectorXd {
public:
  VectorXd(int);
  ~VectorXd();

  /* vector only */
  bool isOrthogonal(VectorXd& v);
  bool isOrthogonal(VectorXd& v, double);
  double squaredNorm();
  double stableNorm();

  VectorXd segment(int, int);

  %extend {

    double __getitem__(int i) {
      return (*$self)(i);
    }

    void __setitem__(int i, double c) {
      (*$self)(i) = c;
    }

  }

};

class VectorXcd {
public:
  VectorXcd(int);
  ~VectorXcd();

  %extend {

    std::complex<double> __getitem__(int i) {
      return (*$self)(i);
    }

    void __setitem__(int i, std::complex<double> c) {
      (*$self)(i) = c;
    }

  }

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

%include "eigen_array.i"


}; /* end of namespace ruby_eigen */

