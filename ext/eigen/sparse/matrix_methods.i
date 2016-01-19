%define SPARSE_MATRIX_Methods(TYPE,  s_type)

  int rows();
  int cols();
  int outerSize();
  int innerSize();
  int nonZeros();

  double squaredNorm();
  double blueNorm();

  bool isCompressed();

  void setIdentity();
  void setZero();

  /* component wise op */
  
  TYPE cwiseSqrt();
  TYPE cwiseInverse();

  TYPE cwiseProduct(TYPE &m);
  TYPE cwiseQuotient(TYPE &m); 

  TYPE operator+(const TYPE &m);
  TYPE operator-(const TYPE &m);
  TYPE operator-();
  TYPE operator*(const TYPE &m);
  TYPE operator*(s_type d);
  TYPE operator/(s_type d);

  TYPE transpose();
  TYPE adjoint();

  %extend {

    s_type __get_item__(int i, int j) {
      return (*$self).coeff(i, j);
    }

  }
%enddef
