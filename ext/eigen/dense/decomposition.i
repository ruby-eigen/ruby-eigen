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

  T solve(const T &b);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

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

  T solve(const T&);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

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

}; /* end of namespace ruby_eigen */
