%module eigen

%include "rb_error_handle.i"

%include std_string.i
%include std_vector.i

%{

#include <complex>
#include <strstream>
#include <string>
#include <Eigen/Core>
#include <Eigen/LU>
#include <Eigen/Eigenvalues>
#include <Eigen/QR>
#include <Eigen/SVD>
#include <Eigen/Cholesky>

%}

/* the following code appears in .cxx file and is also parsed by SWIG. See SWIG.html#SWIG_nn20 */
%inline %{

/* to avoid SWIG warning */
namespace Eigen {};

/* To avoid contaminating Eigen namespace, we use RubyEigen instead of Eigen. */
namespace RubyEigen {
  using namespace Eigen;
  typedef Matrix<bool, Dynamic, Dynamic> MatrixBool;
  typedef Matrix<bool, Dynamic, 1> VectorBool;
  typedef Array<bool, Dynamic, Dynamic> ArrayBool;
  typedef Array<bool, Dynamic, 1> VecBoolCWise;
  typedef PartialPivLU<MatrixXd> PartialPivLUDouble;
  typedef FullPivLU<MatrixXd> FullPivLUDouble;
  typedef FullPivHouseholderQR<MatrixXd> FullPivHouseholderQRDouble;
  typedef JacobiSVD<MatrixXd> JacobiSVDDouble;
  typedef LDLT<MatrixXd> LDLTDouble;
  typedef LLT<MatrixXd> LLTDouble;
};

%} /* inline end */

%template(StdVectorDouble) std::vector<double>;

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

  bool allFinite();
  bool hasNaN();

  void setRandom();
  void setConstant(double);
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

  MatrixXd diagonal();
  MatrixXd diagonal(int);

  MatrixXd inverse();
  double determinant();

  MatrixXd transpose();

  RubyEigen::VectorXcd eigenvalues();

  MatrixXd operator+(const MatrixXd &m);
  MatrixXd operator-(const MatrixXd &m);
  MatrixXd operator-();
  MatrixXd operator*(const MatrixXd &m);
  MatrixXd operator*(double d);
  MatrixXd operator/(double d);

  bool operator==(MatrixXd &m);
  bool isApprox(MatrixXd &m);

  PartialPivLUDouble lu();

  RubyEigen::LDLTDouble ldlt();
  RubyEigen::LLTDouble llt();
  
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

    FullPivLUDouble fullPivLu() {
      return (*self).fullPivLu();
    }

    FullPivHouseholderQRDouble fullPivHouseholderQR() {
      return Eigen::FullPivHouseholderQR<Eigen::MatrixXd>(*$self);
    }

    JacobiSVDDouble svd() {
      return Eigen::JacobiSVD<Eigen::MatrixXd>(*$self, Eigen::ComputeFullU | Eigen::ComputeFullV);
    }
  }

};

class VectorXd {
public:
  VectorXd(int);
  ~VectorXd();

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


%alias FullPivLUDouble::permutationP "p";
%alias FullPivLUDouble::permutationQ "q";

class FullPivLUDouble {
public:
  FullPivLUDouble();
  ~FullPivLUDouble();

  MatrixXd permutationP();
  MatrixXd permutationQ();

  MatrixXd solve(MatrixXd &b);

  %extend {

    MatrixXd u() {
      return (*$self).matrixLU().triangularView<Eigen::Upper>();
    }

    MatrixXd l() {
      return (*$self).matrixLU().triangularView<Eigen::UnitLower>();
    }
  }
};


class PartialPivLUDouble {
public:
  PartialPivLUDouble();
  ~PartialPivLUDouble();
};

%alias FullPivHouseholderQRDouble::matrixQ "q";
%alias FullPivHouseholderQRDouble::colsPermutation "p";

class FullPivHouseholderQRDouble {
public:
  FullPivHouseholderQRDouble();
  ~FullPivHouseholderQRDouble();

  MatrixXd colsPermutation();
  MatrixXd matrixQ();

  %extend {

    MatrixXd r() {
      return (*$self).matrixQR().triangularView<Eigen::Upper>();
    }

  }
};

class JacobiSVDDouble {
public:
  JacobiSVDDouble();
  ~JacobiSVDDouble();

  MatrixXd matrixU();
  MatrixXd matrixV();

  RubyEigen::VectorXd singularValues();

  MatrixXd solve(VectorXd& m);
};

class LDLTDouble {
public:
  LDLTDouble();
  ~LDLTDouble();

  MatrixXd matrixL();
  VectorXd vectorD();

};


class LLTDouble {
public:
  LLTDouble();
  ~LLTDouble();

  MatrixXd matrixL();

};

%include "eigen_array.i"


}; /* end of namespace ruby_eigen */

