namespace RubyEigen {

template<class T>
class SimplicialLDLT {
public:
  SimplicialLDLT();
  SimplicialLDLT(const T&);
  ~SimplicialLDLT();

  void compute(const T&);
  T matrixL();
  T matrixU();
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, RubyEigen::Dynamic> permutationP();
  //  T permutationPinv();

  T solve(const T&);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

  //  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> vectorD();

};

%template(SimplicialLDLTSpDouble) SimplicialLDLT<RubyEigen::SparseMatrix<double> >;

template<class T>
class ConjugateGradient {
public:
  ConjugateGradient();
  ConjugateGradient(const T&);
  ~ConjugateGradient();

  void compute(const T&);

  T solve(const T &b);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);
};

%template(ConjugateGradientDouble)   ConjugateGradient<RubyEigen::MatrixXd>;
%template(ConjugateGradientSpDouble) ConjugateGradient<RubyEigen::SparseMatrix<double> >;

template<class T>
class BiCGSTAB {
public:
  BiCGSTAB();
  BiCGSTAB(const T&);
  ~BiCGSTAB();

  void compute(const T&);

  T solve(const T &b);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);
};
%template(BiCGSTABDouble)   BiCGSTAB<RubyEigen::MatrixXd>;
%template(BiCGSTABSpDouble) BiCGSTAB<RubyEigen::SparseMatrix<double> >;

};
