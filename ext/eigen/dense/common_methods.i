%define DENSE_MATRIX_VECTOR_Common_Methods(TYPE, s_type)

  //  bool allFinite();

%rename("has_nan") hasNaN;
  bool hasNaN();

  void setRandom();
  void setConstant(s_type);
  void setIdentity();
  void setOnes();
  void setZero();

  /* component wise op */

%rename("sqrt") cwiseSqrt;
  TYPE cwiseSqrt();

%rename("__mul__") cwiseProduct;
%rename("__div__") cwiseQuotient;
  TYPE cwiseProduct(TYPE &m);
  TYPE cwiseQuotient(TYPE &m); 

  TYPE operator+(const TYPE &m);
  TYPE operator-(const TYPE &m);
  TYPE operator-();
  TYPE operator/(s_type d);

%rename("eq") cwiseEqual;
%rename("ne") cwiseNotEqual;
  BoolMatrix cwiseEqual(const TYPE&);
  BoolMatrix cwiseNotEqual(const TYPE&);

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

%define ExtendForCwiseOp(MV)
  %extend {

    MV exp() {
      return $self->array().exp();
    }

    MV log() {
      return $self->array().log();
    }

    MV log1p() {
      return $self->array().log1p();
    }

    MV log10() {
      return $self->array().log10();
    }

    MV pow(const MV &m) {
      return $self->array().pow(m.array());
    }

    MV rsqrt() {
      return $self->array().rsqrt();
    }

    MV square() {
      return $self->array().square();
    }

    MV cube() {
      return $self->array().cube();
    }

    MV abs2() {
      return $self->array().abs2();
    }

    MV sin() {
      return $self->array().sin();
    }

    MV cos() {
      return $self->array().cos();
    }

    MV tan() {
      return $self->array().tan();
    }

    MV asin() {
      return $self->array().asin();
    }

    MV acos() {
      return $self->array().acos();
    }

    MV atan() {
      return $self->array().atan();
    }

    MV sinh() {
      return $self->array().sinh();
    }

    MV cosh() {
      return $self->array().cosh();
    }

    MV tanh() {
      return $self->array().tanh();
    }

  }
%enddef

