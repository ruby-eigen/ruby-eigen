%rename(CMatrixDouble) ArrayXXd;
%rename(CVectorDouble) ArrayXd;
%rename(CMatrixComplex) ArrayXXcd;
%rename(CVectorComplex) ArrayXcd;

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

  s_type sum();
  s_type prod();

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

  RubyEigen::MatrixDouble matrix();

  DENSE_ARRAY_Real_Methods(ArrayXXd, double, RubyEigen::CMatrixBool)
  DENSE_ARRAY_Methods(ArrayXXd, ArrayXXd, double, RubyEigen::CMatrixBool)
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

  DENSE_ARRAY_Real_Methods(ArrayXd, double, CVectorBool)
  DENSE_ARRAY_Methods(ArrayXd, ArrayXd, double, CVectorBool)

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

  DENSE_ARRAY_Methods(ArrayXXcd, ArrayXXd, std::complex<double>, CMatrixBool)

  %extend {
    std::complex<double> __getitem__(int i, int j) {
      return (*$self)(i,j);
    }

    void __setitem__(int i, int j, double c) {
      (*$self)(i,j) = c;
    }

  }
};

%rename("__and__") CMatrixBool::operator&&;
%rename("__or__") CMatrixBool::operator||;

class CMatrixBool {
public:
  CMatrixBool(int,int);
  ~CMatrixBool();
  bool all();
  bool any();
  int count();

  CMatrixBool operator&&(const CMatrixBool&);
  CMatrixBool operator||(const CMatrixBool&);

  %extend{
    RubyEigen::ArrayXXd select(MatrixDouble &a, MatrixDouble &b) {
      return (*$self).select(a, b);
    }

    bool __getitem__(int i, int j) {
      return (*$self)(i,j);
    }

    void __setitem__(int i, int j, bool c) {
      (*$self)(i,j) = c;
    }

  }
};

%rename("__and__") CVectorBool::operator&&;
%rename("__or__") CVectorBool::operator||;

class CVectorBool {
public:
  CVectorBool(int,int);
  ~CVectorBool();
  bool all();
  bool any();
  int count();

  CVectorBool operator&&(const CVectorBool&);
  CVectorBool operator||(const CVectorBool&);

  %extend{
    RubyEigen::ArrayXd select(VectorXd &a, VectorXd &b) {
      return (*$self).select(a, b);
    }

    bool __getitem__(int i) {
      return (*$self)(i);
    }

    void __setitem__(int i, bool c) {
      (*$self)(i) = c;
    }
  }
};
