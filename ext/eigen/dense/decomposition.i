namespace RubyEigen {

%alias FullPivLU::permutationP "p";
%alias FullPivLU::permutationQ "q";

template<class T>
class FullPivLU {
public:
  FullPivLU();
  ~FullPivLU();

  T permutationP();
  T permutationQ();

  T solve(const T &b);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

  %extend {

    T u() {
      return (*$self).matrixLU().triangularView<Eigen::Upper>();
    }

    T l() {
      return (*$self).matrixLU().triangularView<Eigen::UnitLower>();
    }
  }
};


%template(FullPivLUDouble) RubyEigen::FullPivLU<RubyEigen::DFloatMatrix>;
%template(FullPivLUComplex) RubyEigen::FullPivLU<RubyEigen::DComplexMatrix>;

template<class T>
class PartialPivLU {
public:
  PartialPivLU();
  ~PartialPivLU();
};

%template(PartialPivLUDouble) RubyEigen::PartialPivLU<RubyEigen::DFloatMatrix>;
%template(PartialPivLUComplex) RubyEigen::PartialPivLU<RubyEigen::DComplexMatrix>;


%alias FullPivHouseholderQR::matrixQ "q";
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

    T r() {
      return (*$self).matrixQR().triangularView<Eigen::Upper>();
    }

  }
};

%template(FullPivHouseholderQRDouble) RubyEigen::FullPivHouseholderQR<RubyEigen::DFloatMatrix>;
%template(FullPivHouseholderQRComplex) RubyEigen::FullPivHouseholderQR<RubyEigen::DComplexMatrix>;


template<class T>
class JacobiSVD {
public:
  JacobiSVD();
  ~JacobiSVD();

  T matrixU();
  T matrixV();

  DFloatVector singularValues();

  T solve(const T&);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

};

%template(JacobiSVDDouble) RubyEigen::JacobiSVD<RubyEigen::DFloatMatrix>;
%template(JacobiSVDComplex) RubyEigen::JacobiSVD<RubyEigen::DComplexMatrix>;


template<class T>
class LDLT {
public:
  LDLT();
  ~LDLT();

  T matrixL();
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> vectorD();

};

%template(LDLTDouble) RubyEigen::LDLT<RubyEigen::DFloatMatrix>;
%template(LDLTComplex) RubyEigen::LDLT<RubyEigen::DComplexMatrix>;


template<class T>
class LLT {
public:
  LLT();
  ~LLT();

  T matrixL();

};

%template(LLTDouble) RubyEigen::LLT<RubyEigen::DFloatMatrix>;
%template(LLTComplex) RubyEigen::LLT<RubyEigen::DComplexMatrix>;

}; /* end of namespace ruby_eigen */
