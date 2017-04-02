namespace RubyEigen {

template<typename T>
class SparseMatrix {
public:
  SparseMatrix(size_t, size_t);
  ~SparseMatrix();

  /* real matrix only */
  //  SparseMatrix cwiseAbs();
  //  SparseMatrix cwiseAbs2();

  //  SparseMatrix cwiseMax(const SparseMatrix &m);
  //  SparseMatrix cwiseMin(const SparseMatrix &m);

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

%rename("__mul__") cwiseProduct;
%rename("__div__") cwiseQuotient;

  SparseMatrix cwiseProduct(SparseMatrix &m);
  SparseMatrix cwiseQuotient(SparseMatrix &m); 

  SparseMatrix operator+(const SparseMatrix &m);
  SparseMatrix operator-(const SparseMatrix &m);
  SparseMatrix operator-();

%rename("dot") operator*;

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

};  // class SparseMatrix

%template(SpMatrixDouble) SparseMatrix<double>;
%template(SpMatrixFloat)  SparseMatrix<float>;
%template(SpMatrixDComplex)  SparseMatrix<std::complex<double>>;
%template(SpMatrixSComplex)  SparseMatrix<std::complex<float>>;

}; // namespace RubyEigen 

%{
namespace RubyEigen {
template<class T>
class SpMatrixIter : public SparseMatrix<T>::InnerIterator {
public:

  SpMatrixIter(SparseMatrix<T>& m, size_t i) : SparseMatrix<T>::InnerIterator(m, i) {}
  ~SpMatrixIter() {}

};
};
%}

namespace RubyEigen {

template<class T>
class SpMatrixIter : public SparseMatrix<T>::InnerIterator {
public:
  SpMatrixIter(SparseMatrix<T>&, size_t);
  ~SpMatrixIter();

  T value();
  size_t row();
  size_t col();
  size_t index();
  size_t outer();

%rename("end?") end;

  %extend {

    T next() {
      if (*$self){
        ++(*$self);
        return (*$self).value();
      }else{
        return 0;
      }
    }

    bool end(){
      if (*$self) {
        return false;
      }else{
        return true;
      }
    }

    void set(T x) {
      (*$self).valueRef() = x;
    }

  }

}; // class SpMatrixIter

%template(SpMatrixDoubleIter) RubyEigen::SpMatrixIter<double>;
%template(SpMatrixSFloatIter) RubyEigen::SpMatrixIter<float>;
%template(SpMatrixDComplexIter) RubyEigen::SpMatrixIter<std::complex<double>>;
%template(SpMatrixSComplexIter) RubyEigen::SpMatrixIter<std::complex<float>>;

}; // namespace RubyEigen 
