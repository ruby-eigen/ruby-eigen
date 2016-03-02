namespace RubyEigen {

template<typename T>
class SparseMatrix {
public:
  SparseMatrix(size_t, size_t);
  ~SparseMatrix();

  /* real matrix only */
  SparseMatrix<T> cwiseAbs();
  SparseMatrix<T> cwiseAbs2();

  SparseMatrix<T> cwiseMax(const SparseMatrix<T> &m);
  SparseMatrix<T> cwiseMin(const SparseMatrix<T> &m);

  SPARSE_MATRIX_Methods(SparseMatrix<T>,  T)

};
%template(SpMatrixFloat) SparseMatrix<float>;
%template(SpMatrixDouble) SparseMatrix<double>;

class SpMatrixDoubleIter {
public:
  SpMatrixDoubleIter(RubyEigen::SpMatrixDouble&, size_t);
  ~SpMatrixDoubleIter();

  double value();
  int row();
  int col();
  int index();
  int outer();

%rename("end?") end;

  %extend {

    double next() {
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

    void set(double x) {
      (*$self).valueRef() = x;
    }

  }
};

class SpMatrixFloatIter {
public:
  SpMatrixFloatIter(RubyEigen::SpMatrixFloat&, size_t);
  ~SpMatrixFloatIter();

  float value();
  int row();
  int col();
  int index();
  int outer();

%rename("end?") end;

  %extend {

    float next() {
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

    void set(float x) {
      (*$self).valueRef() = x;
    }

  }
};

};
