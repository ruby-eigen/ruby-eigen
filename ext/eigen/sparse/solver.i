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

%template(SimplicialLDLTSpDouble) SimplicialLDLT<RubyEigen::SparseMatrix<double> >;

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

%template(ConjugateGradientDouble)   ConjugateGradient<RubyEigen::DFloatMatrix>;
%template(ConjugateGradientSpDouble) ConjugateGradient<RubyEigen::SparseMatrix<double> >;

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

class SparseLUDouble {
public:
  SparseLUDouble(const RubyEigen::SparseMatrix<double>&);
  ~SparseLUDouble();

  RubyEigen::SparseMatrix<double> solve(const RubyEigen::SparseMatrix<double>&);
  RubyEigen::DFloatVector solve(const RubyEigen::DFloatVector&);
};

class SparseLUFloat {
public:
  SparseLUFloat(const RubyEigen::SparseMatrix<float>&);
  ~SparseLUFloat();

  RubyEigen::SparseMatrix<float> solve(const RubyEigen::SparseMatrix<float>&);
  //  RubyEigen::DFloatVector solve(const RubyEigen::VectorXd&);
};

};
