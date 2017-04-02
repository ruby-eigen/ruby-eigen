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


%template(FullPivLUDouble) RubyEigen::FullPivLU<RubyEigen::MatrixDouble>;
%template(FullPivLUComplex) RubyEigen::FullPivLU<RubyEigen::MatrixDComplex>;

template<class T>
class PartialPivLU {
public:
  PartialPivLU();
  ~PartialPivLU();
};

%template(PartialPivLUDouble) RubyEigen::PartialPivLU<RubyEigen::MatrixDouble>;
%template(PartialPivLUComplex) RubyEigen::PartialPivLU<RubyEigen::MatrixDComplex>;


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

%template(FullPivHouseholderQRDouble) RubyEigen::FullPivHouseholderQR<RubyEigen::MatrixDouble>;
%template(FullPivHouseholderQRComplex) RubyEigen::FullPivHouseholderQR<RubyEigen::MatrixDComplex>;


template<class T>
class JacobiSVD {
public:
  JacobiSVD();
  ~JacobiSVD();

  T matrixU();
  T matrixV();

  VectorDFloat singularValues();

  T solve(const T&);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

};

%template(JacobiSVDDouble) RubyEigen::JacobiSVD<RubyEigen::MatrixDouble>;
%template(JacobiSVDComplex) RubyEigen::JacobiSVD<RubyEigen::MatrixDComplex>;


template<class T>
class LDLT {
public:
  LDLT();
  ~LDLT();

  T matrixL();
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> vectorD();

};

%template(LDLTDouble) RubyEigen::LDLT<RubyEigen::MatrixDouble>;
%template(LDLTComplex) RubyEigen::LDLT<RubyEigen::MatrixDComplex>;


template<class T>
class LLT {
public:
  LLT();
  ~LLT();

  T matrixL();

};

%template(LLTDouble) RubyEigen::LLT<RubyEigen::MatrixDouble>;
%template(LLTComplex) RubyEigen::LLT<RubyEigen::MatrixDComplex>;

}; /* end of namespace ruby_eigen */
