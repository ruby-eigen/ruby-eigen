%define SPARSE_MATRIX_Methods(TYPE,  s_type)

  int rows();
  int cols();
  int outerSize();
  int innerSize();
  int nonZeros();

  double squaredNorm();
  double blueNorm();

%rename(__reserve__) reserve;
  void reserve(int);
  void reserve( std::vector<int> );

  void makeCompressed();
  bool isCompressed();
  void uncompress();

  void prune(double);

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

%alias coeff "[]";

  s_type coeff(int, int);

  %extend {

    void __setitem__(int i, int j, s_type val) {
      (*$self).coeffRef(i, j) = val;
    }

    void __insert__(int i, int j, s_type val) {
      (*$self).insert(i,j) = val;
    }

    std::vector< int > innerIndices(){
      std::vector< int > v((*$self).innerIndexPtr(), (*$self).innerIndexPtr() + (*$self).nonZeros());
      return v;
    }

    std::vector< int > outerIndices(){
      std::vector< int > v((*$self).outerIndexPtr(), (*$self).outerIndexPtr() + (*$self).outerSize()+1);
      return v;
    }

    std::vector< s_type > values(){
      std::vector< s_type > v((*$self).valuePtr(), (*$self).valuePtr() + (*$self).nonZeros());
      return v;
    }
  }
%enddef
