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
  SpMatrixDoubleIter(RubyEigen::SpMatrixDouble, int);
  ~SpMatrixDoubleIter();
  
};

};
