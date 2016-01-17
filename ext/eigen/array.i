%rename(MatrixDoubleCWise) ArrayXXd;
%rename(VectorDoubleCWise) ArrayXd;
%rename(MatrixComplexCWise) ArrayXXcd;
%rename(MatrixComplexCWise) ArrayXcd;

%define DENSE_ARRAY_Real_Methods(TYPE, s_type, boolklass)

  boolklass operator>=(const TYPE&);
  boolklass operator>(const TYPE&);
  boolklass operator<=(const TYPE&);
  boolklass operator<(const TYPE&);

  TYPE max(const TYPE&);
  TYPE max(s_type);
  TYPE min(const TYPE&);
  TYPE min(s_type);
 
  s_type maxCoeff();
  s_type minCoeff();

%enddef

%define DENSE_ARRAY_Methods(TYPE, R_TYPE, s_type, boolklass)

  void setOnes();
  void setRandom();
  void setZero();

  /* element wise op */
  RubyEigen:: ## R_TYPE abs();
  RubyEigen:: ## R_TYPE abs2();
  TYPE square();
  TYPE cube();
  TYPE sin();
  TYPE cos();
  TYPE tan();
  TYPE asin();
  TYPE acos();
  TYPE log();
  TYPE exp();
  TYPE sqrt();
  TYPE pow(s_type);
  //  TYPE inverse();

  /* element wise compare */
  boolklass operator==(const TYPE&);

  TYPE operator+(const TYPE&);
  TYPE operator-(const TYPE&);
  TYPE operator*(const TYPE&);
  TYPE operator*(s_type);
  TYPE operator/(const TYPE&);
  TYPE operator/(s_type);
  TYPE operator-();

  bool isApprox(const TYPE&);
  bool isApprox(const TYPE&, const double);
  bool isApproxToConstant(const s_type);
  bool isApproxToConstant(const s_type, const double);
  bool isMuchSmallerThan(const double);
  bool isMuchSmallerThan(const double, const double);
  bool isMuchSmallerThan(const TYPE&);
  bool isMuchSmallerThan(const TYPE&, double);

  bool isOnes();
  bool isOnes(const double);
  bool isZero();
  bool isZero(const double);

  bool hasNaN();

%enddef

class ArrayXXd {
public:
  ArrayXXd(int,int);
  ~ArrayXXd();

  RubyEigen::MatrixXd matrix();

  DENSE_ARRAY_Real_Methods(ArrayXXd, double, RubyEigen::MatrixBoolCWise)
  DENSE_ARRAY_Methods(ArrayXXd, ArrayXXd, double, RubyEigen::MatrixBoolCWise)
  %extend {
    double __getitem__(int i, int j) {
      return (*$self)(i, j);
    }

    void __setitem__(int i, int j, double c) {
      (*$self)(i, j) = c;
    }
  }
};

class ArrayXd {
public:
  ArrayXd(int);
  ~ArrayXd();

  RubyEigen::VectorXd matrix();

  DENSE_ARRAY_Real_Methods(ArrayXd, double, VectorBoolCWise)
  DENSE_ARRAY_Methods(ArrayXd, ArrayXd, double, VectorBoolCWise)

  %extend {
    double __getitem__(int i) {
      return (*$self)(i);
    }

    void __setitem__(int i, double c) {
      (*$self)(i) = c;
    }
  }
};

class ArrayXXcd {
public:
  ArrayXXcd(int,int);
  ~ArrayXXcd();

  RubyEigen::MatrixXcd matrix();

  DENSE_ARRAY_Methods(ArrayXXcd, ArrayXXd, std::complex<double>, MatrixBoolCWise)

  %extend {
    std::complex<double> __getitem__(int i, int j) {
      return (*$self)(i,j);
    }

    void __setitem__(int i, int j, double c) {
      (*$self)(i,j) = c;
    }

  }
};

class MatrixBoolCWise {
public:
  MatrixBoolCWise(int,int);
  ~MatrixBoolCWise();
  bool all();
  bool any();

  MatrixBoolCWise operator+(const MatrixBoolCWise&);

  %extend{
    MatrixXd select(MatrixXd &a, MatrixXd &b) {
      return (*$self).select(a, b);
    }
  }
};
