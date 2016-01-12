%rename(MatrixDoubleCWise) ArrayXXd;
%rename(VectorDoubleCWise) ArrayXd;


%define DENSEBASE_ARRAY_METHOD(klass,type,boolklass)

  void setOnes();
  void setRandom();
  void setZero();

  /* element wise op */
  klass abs();
  klass abs2();
  klass square();
  klass cube();
  klass sin();
  klass cos();
  klass tan();
  klass asin();
  klass acos();
  klass log();
  klass exp();
  klass sqrt();
  klass pow(type);
  //  klass inverse();

  /* element wise compare */
  boolklass operator==(const klass&);

  /* element wise binary op */
  klass max(const klass&);
  klass max(type);
  klass min(const klass&);
  klass min(type);

  klass operator+(const klass&);
  klass operator-(const klass&);
  klass operator*(const klass&);
  klass operator*(type);
  klass operator/(const klass&);
  klass operator/(type);
  klass operator-();

  bool isApprox(const klass&);
  bool isApprox(const klass&, type);
  bool isApproxToConstant(type);
  bool isApproxToConstant(type, type);
  bool isMuchSmallerThan(type);
  bool isMuchSmallerThan(type, type);
  bool isMuchSmallerThan(const klass&);
  bool isMuchSmallerThan(const klass&, type);

  bool isOnes();
  bool isOnes(type);
  bool isZero();
  bool isZero(type);
  bool hasNaN();

  type maxCoeff();
  type minCoeff();

%enddef

class ArrayXXd {
public:
  ArrayXXd(int,int);
  ~ArrayXXd();

DENSEBASE_ARRAY_METHOD(ArrayXXd, double, ArrayBool)

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

DENSEBASE_ARRAY_METHOD(ArrayXd, double, VecBoolCWise)

  %extend {
    double __getitem__(int i) {
      return (*$self)(i);
    }

    void __setitem__(int i, double c) {
      (*$self)(i) = c;
    }

  }
};

class ArrayBool {
public:
  ArrayBool(int,int);
  ~ArrayBool();
  bool all();
  bool any();

  ArrayBool operator+(const ArrayBool&);

  %extend{
    MatrixXd select(MatrixXd &a, MatrixXd &b) {
      return (*$self).select(a, b);
    }
  }
};
