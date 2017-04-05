namespace RubyEigen {

%alias FullPivLU::permutationP "p";
%alias FullPivLU::permutationQ "q";

%alias FullPivLU::matrix_u "u";
%alias FullPivLU::matrix_l "l";

template<class T>
class FullPivLU {
public:
  FullPivLU();
  ~FullPivLU();

  T permutationP();
  T permutationQ();

  T::Scalar determinant();
  T inverse();
  bool isInvertible();

  T solve(const T &b);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

  %extend {

    T matrix_u() {
      return (*$self).matrixLU().triangularView<Eigen::Upper>();
    }

    T matrix_l() {
      return (*$self).matrixLU().triangularView<Eigen::UnitLower>();
    }
  }
};

%template(DFloatFullPivLU)   RubyEigen::FullPivLU<RubyEigen::DFloatMatrix>;
%template(SFloatFullPivLU)   RubyEigen::FullPivLU<RubyEigen::SFloatMatrix>;
%template(DComplexFullPivLU) RubyEigen::FullPivLU<RubyEigen::DComplexMatrix>;
%template(SComplexFullPivLU) RubyEigen::FullPivLU<RubyEigen::SComplexMatrix>;

template<class T>
class PartialPivLU {
public:
  PartialPivLU();
  ~PartialPivLU();
};

%template(DFloatPartialPivLU) RubyEigen::PartialPivLU<RubyEigen::DFloatMatrix>;
%template(SFloatPartialPivLU) RubyEigen::PartialPivLU<RubyEigen::SFloatMatrix>;
%template(DComplexPartialPivLU) RubyEigen::PartialPivLU<RubyEigen::DComplexMatrix>;
%template(SComplexPartialPivLU) RubyEigen::PartialPivLU<RubyEigen::SComplexMatrix>;


%alias FullPivHouseholderQR::matrixQ "q";
%alias FullPivHouseholderQR::matrix_r "r";
%alias FullPivHouseholderQR::colsPermutation "p";

template<class T>
class FullPivHouseholderQR {
public:
  FullPivHouseholderQR();
  ~FullPivHouseholderQR();

  T colsPermutation();
  T matrixQ();

  T solve(const T &b);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

  %extend {

    T matrix_r() {
      return (*$self).matrixQR().triangularView<Eigen::Upper>();
    }

  }
};

%template(DFloatFullPivHouseholderQR) RubyEigen::FullPivHouseholderQR<RubyEigen::DFloatMatrix>;
%template(SFloatFullPivHouseholderQR) RubyEigen::FullPivHouseholderQR<RubyEigen::SFloatMatrix>;
%template(DComplexFullPivHouseholderQR) RubyEigen::FullPivHouseholderQR<RubyEigen::DComplexMatrix>;
%template(SComplexFullPivHouseholderQR) RubyEigen::FullPivHouseholderQR<RubyEigen::SComplexMatrix>;


template<class T>
class JacobiSVD {
public:
  JacobiSVD();
  ~JacobiSVD();

  T matrixU();
  T matrixV();

  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> singularValues();

  T solve(const T&);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

};

%template(DFlaotJacobiSVD) RubyEigen::JacobiSVD<RubyEigen::DFloatMatrix>;
%template(SFlaotJacobiSVD) RubyEigen::JacobiSVD<RubyEigen::SFloatMatrix>;
%template(DComplexJacobiSVD) RubyEigen::JacobiSVD<RubyEigen::DComplexMatrix>;
%template(SComplexJacobiSVD) RubyEigen::JacobiSVD<RubyEigen::SComplexMatrix>;


template<class T>
class LDLT {
public:
  LDLT();
  ~LDLT();

  T matrixL();
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> vectorD();

};

%template(DFloatLDLT) RubyEigen::LDLT<RubyEigen::DFloatMatrix>;
%template(SFloatLDLT) RubyEigen::LDLT<RubyEigen::SFloatMatrix>;
%template(DComplexLDLT) RubyEigen::LDLT<RubyEigen::DComplexMatrix>;
%template(SComplexLDLT) RubyEigen::LDLT<RubyEigen::SComplexMatrix>;


template<class T>
class LLT {
public:
  LLT();
  ~LLT();

  T matrixL();

};

%template(DFloatLLT) RubyEigen::LLT<RubyEigen::DFloatMatrix>;
%template(SFloatLLT) RubyEigen::LLT<RubyEigen::SFloatMatrix>;
%template(DComplexLLT) RubyEigen::LLT<RubyEigen::DComplexMatrix>;
%template(SComplexLLT) RubyEigen::LLT<RubyEigen::SComplexMatrix>;

}; /* end of namespace ruby_eigen */
