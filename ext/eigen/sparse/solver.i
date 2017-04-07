namespace RubyEigen {

template<class T>
class SimplicialLDLT {
public:
  SimplicialLDLT();
  SimplicialLDLT(const T&);
  ~SimplicialLDLT();

  void analyzePattern(const T&);
  void compute(const T&);
  T matrixL();
  T matrixU();
  RubyEigen::PermutationMatrix permutationP();
  RubyEigen::PermutationMatrix permutationPinv();

  T solve(const T&);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> vectorD();

};

%template(DFloatSimplicialLDLT) SimplicialLDLT<RubyEigen::SparseMatrix<double> >;
%template(SFloatSimplicialLDLT) SimplicialLDLT<RubyEigen::SparseMatrix<float> >;
%template(DComplexSimplicialLDLT) SimplicialLDLT<RubyEigen::SparseMatrix<std::complex<double>>>;
%template(SComplexSimplicialLDLT) SimplicialLDLT<RubyEigen::SparseMatrix<std::complex<float>>>;

template<class T>
class SimplicialLLT {
public:
  SimplicialLLT();
  SimplicialLLT(const T&);
  ~SimplicialLLT();

  void analyzePattern(const T&);
  void compute(const T&);

  T solve(const T&);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

};

%template(DFloatSimplicialLLT) SimplicialLLT<RubyEigen::SparseMatrix<double>>;
%template(SFloatSimplicialLLT) SimplicialLLT<RubyEigen::SparseMatrix<float>>;
%template(DComplexSimplicialLLT) SimplicialLLT<RubyEigen::SparseMatrix<std::complex<double>>>;
%template(SComplexSimplicialLLT) SimplicialLLT<RubyEigen::SparseMatrix<std::complex<float>>>;

template<class T>
class SparseLU {
public:
  SparseLU();
  SparseLU(const T&);
  ~SparseLU();

  void analyzePattern(const T&);
  void compute(const T&);

  RubyEigen::SparseMatrix<T::Scalar> solve(const RubyEigen::SparseMatrix<T::Scalar>&);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

};

%template(DFloatSparseLU) SparseLU<RubyEigen::SparseMatrix<double>>;
%template(DSloatSparseLU) SparseLU<RubyEigen::SparseMatrix<float>>;
%template(DComplexSparseLU) SparseLU<RubyEigen::SparseMatrix<std::complex<double>>>;
%template(SComplexSparseLU) SparseLU<RubyEigen::SparseMatrix<std::complex<float>>>;

template<class T, class Order>
class SparseQR {
public:
  SparseQR();
  SparseQR(const T&);
  ~SparseQR();

  void analyzePattern(const T&);
  void compute(const T&);

  T matrixR();

  int cols();
  int rows();
  int rank();

  std::string lastErrorMessage();

  RubyEigen::SparseMatrix<T::Scalar> solve(const RubyEigen::SparseMatrix<T::Scalar>&);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);

  %extend{
    RubyEigen::SparseMatrix<T::Scalar> matrixQ(){
      RubyEigen::SparseMatrix<T::Scalar> Q;
      Q = $self->matrixQ();
      return Q;
    }
  }
};

%template(DFloatSparseQR) SparseQR<RubyEigen::SparseMatrix<double>, RubyEigen::COLAMDOrdering<int>>;
%template(SFloatSparseQR) SparseQR<RubyEigen::SparseMatrix<float>, RubyEigen::COLAMDOrdering<int>>;
%template(DComplexSparseQR) SparseQR<RubyEigen::SparseMatrix<std::complex<double>>, RubyEigen::COLAMDOrdering<int>>;
%template(SComplexSparseQR) SparseQR<RubyEigen::SparseMatrix<std::complex<float>>, RubyEigen::COLAMDOrdering<int>>;

template<class T>
class ConjugateGradient {
public:
  ConjugateGradient();
  ConjugateGradient(const T&);
  ~ConjugateGradient();

  void compute(const T&);
  void setTolerance (const double&);
  double tolerance();
  void setMaxIterations(int);
  int maxIterations();

  double error();
  int iterations();

  T solve(const T &b);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);
};

%template(DFloatConjugateGradientDouble)   ConjugateGradient<RubyEigen::DFloatMatrix>;
%template(ConjugateGradientSpDouble) ConjugateGradient<RubyEigen::SparseMatrix<double> >;

  /*
template<class T>
class BiCGSTAB {
public:
  BiCGSTAB();
  BiCGSTAB(const T&);
  ~BiCGSTAB();

  void compute(const T&);
  void setTolerance (const double&);
  double tolerance();
  void setMaxIterations(int);
  int maxIterations();

  double error();
  int iterations();

  T solve(const T &b);
  RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1> solve(const RubyEigen::Matrix<T::Scalar, RubyEigen::Dynamic, 1>&);
};
%template(BiCGSTABDouble)   BiCGSTAB<RubyEigen::DFloatMatrix>;
%template(BiCGSTABSpDouble) BiCGSTAB<RubyEigen::SparseMatrix<double> >;

  */
};
