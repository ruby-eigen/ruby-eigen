%define DENSE_MATRIX_VECTOR_Common_Methods(TYPE, s_type)

  //  bool allFinite();
  bool hasNaN();

  void setRandom();
  void setConstant(s_type);
  void setIdentity();
  void setOnes();
  void setZero();

  /* component wise op */
  
  TYPE cwiseSqrt();
  TYPE cwiseInverse();

  TYPE cwiseProduct(TYPE &m);
  TYPE cwiseQuotient(TYPE &m); 

  TYPE operator+(const TYPE &m);
  TYPE operator-(const TYPE &m);
  TYPE operator-();
  TYPE operator/(s_type d);

  bool operator==(TYPE &m);
  bool isApprox(TYPE &m);
  bool isApprox(TYPE &m, double);
  bool isApproxToConstant(s_type);
  bool isConstant(s_type);

  bool isMuchSmallerThan(double);
  bool isMuchSmallerThan(double, double);
  bool isMuchSmallerThan(TYPE& m);
  bool isMuchSmallerThan(TYPE& m, double);

  bool isOnes();
  bool isOnes(double);
  bool isZero();
  bool isZero(double);

  TYPE adjoint();

%enddef
