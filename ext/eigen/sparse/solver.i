namespace RubyEigen {

template<class T>
class ConjugateGradient {
public:
  ConjugateGradient(const T&);
  ~ConjugateGradient();

  T solve(const T &b);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);
};

%template(ConjugateGradientDouble)   ConjugateGradient<RubyEigen::MatrixXd>;
%template(ConjugateGradientSpDouble) ConjugateGradient<RubyEigen::SparseMatrix<double> >;

template<class T>
class BiCGSTAB {
public:
  BiCGSTAB(const T&);
  ~BiCGSTAB();

  T solve(const T &b);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);
};
%template(BiCGSTABDouble)   BiCGSTAB<RubyEigen::MatrixXd>;
%template(BiCGSTABSpDouble) BiCGSTAB<RubyEigen::SparseMatrix<double> >;

};
