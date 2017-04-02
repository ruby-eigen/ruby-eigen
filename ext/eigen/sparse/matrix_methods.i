%define SPARSE_MATRIX_Methods()

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

  void prune(T);

  void setIdentity();
  void setZero();

  /* component wise op */
  
  SparseMatrix cwiseSqrt();
  SparseMatrix cwiseInverse();

  SparseMatrix cwiseProduct(SparseMatrix &m);
  SparseMatrix cwiseQuotient(SparseMatrix &m); 

  SparseMatrix operator+(const SparseMatrix &m);
  SparseMatrix operator-(const SparseMatrix &m);
  SparseMatrix operator-();
  SparseMatrix operator*(const SparseMatrix &m);
  SparseMatrix operator*(T d);
  SparseMatrix operator/(T d);

  SparseMatrix transpose();
  SparseMatrix adjoint();

%alias coeff "[]";

  T coeff(int, int);

  %extend {

    void __setitem__(int i, int j, T val) {
      (*$self).coeffRef(i, j) = val;
    }

    void __insert__(int i, int j, T val) {
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

    std::vector< T > values(){
      std::vector< T > v((*$self).valuePtr(), (*$self).valuePtr() + (*$self).nonZeros());
      return v;
    }
  }
%enddef
