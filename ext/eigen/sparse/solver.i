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

  void compute(const T&);
  //  T matrixL();
  //  T matrixU();

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
  SparseLU(const RubyEigen::SparseMatrix<double>&);
  ~SparseLU();

  void compute(const T&);
  //  T matrixL();
  //  T matrixU();

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
  SparseQR(const RubyEigen::SparseMatrix<double>&);
  ~SparseQR();

  int cols();
  int rows();
  int rank();

  std::string lastErrorMessage();

  //  RubyEigen::SparseMatrix<double> matrixQ();
  //  RubyEigen::SparseMatrix<double> matrixR();

  RubyEigen::SparseMatrix<double> solve(const RubyEigen::SparseMatrix<double>&);
  RubyEigen::DFloatVector solve(const RubyEigen::DFloatVector&);

};

%template(DFloatSparseQR) SparseQR<RubyEigen::SparseMatrix<double>, RubyEigen::COLAMDOrdering<int>>;

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


class SparseQRDouble {
public:
  SparseQRDouble(const RubyEigen::SparseMatrix<double>&);
  ~SparseQRDouble();


  int cols();
  int rows();
  int rank();

  std::string lastErrorMessage();

  %extend{
    RubyEigen::SparseMatrix<double> matrixQ(){
      RubyEigen::SparseMatrix<double> Q;
      Q = $self->matrixQ();
      return Q;
    }

    RubyEigen::SparseMatrix<double> matrixR(){
      RubyEigen::SparseMatrix<double> R;
      R = $self->matrixR();
      return R;
    }
  }

  RubyEigen::SparseMatrix<double> solve(const RubyEigen::SparseMatrix<double>&);
  RubyEigen::DFloatVector solve(const RubyEigen::DFloatVector&);
};

  */
};
