namespace RubyEigen {

class SpMatrixDouble {
public:
  SpMatrixDouble(int, int);
  ~SpMatrixDouble();

  /* real matrix only */
  SpMatrixDouble cwiseAbs();
  SpMatrixDouble cwiseAbs2();

  SpMatrixDouble cwiseMax(SpMatrixDouble &m);
  SpMatrixDouble cwiseMin(SpMatrixDouble &m);

SPARSE_MATRIX_Methods(SpMatrixDouble,  double)

};

class SpMatrixDoubleIter {
public:
  SpMatrixDoubleIter(RubyEigen::SpMatrixDouble&, int);
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

    void set(double i) {
      (*$self).valueRef() = i;
    }

  }
};

};
