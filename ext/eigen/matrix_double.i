namespace RubyEigen {

%rename(MatrixDouble) MatrixXd; 

%alias MatrixXd::operator== "__eq__";

class MatrixXd {
public:
  MatrixXd(int, int);
  ~MatrixXd();

  /* real matrix only */
  MatrixXd cwiseAbs();
  MatrixXd cwiseAbs2();

  MatrixXd cwiseMax(MatrixXd &m);
  MatrixXd cwiseMax(double);
  MatrixXd cwiseMin(MatrixXd &m);
  MatrixXd cwiseMin(double);

  double maxCoeff();
  double minCoeff();

  RubyEigen::ArrayXXd array();

  RubyEigen::MatrixXd real();

  DENSE_MATRIX_VECTOR_Common_Methods(MatrixXd, VectorXd, double)
  DENSE_MATRIX_Methods(MatrixXd, VectorXd, double)
  DENSE_MATRIX_RC_Methods(MatrixXd, VectorXd, double)

  %extend {
    RubyEigen::Block< RubyEigen::MatrixXd > __ref__(int i, int j, int rows, int cols) {
      return (*$self).block(i, j, rows, cols);
    }
  }

}; /* end class MatrixXd */

class MatrixDoubleRef {
public:
  MatrixDoubleRef(RubyEigen::MatrixXd&, int, int, int, int);
  ~MatrixDoubleRef();

  /* real matrix only */
  MatrixXd cwiseAbs();
  MatrixXd cwiseAbs2();

  MatrixXd cwiseMax(MatrixXd &m);
  MatrixXd cwiseMax(double);
  MatrixXd cwiseMin(MatrixXd &m);
  MatrixXd cwiseMin(double);

  double maxCoeff();
  double minCoeff();

  Eigen::ArrayXXd array();

  RubyEigen::MatrixXd real();

  DENSE_MATRIX_VECTOR_Common_Methods(MatrixXd, VectorXd, double)
  DENSE_MATRIX_Methods(MatrixXd, VectorXd, double)
  DENSE_MATRIX_RC_Methods(MatrixXd, VectorXd, double)
};

}; /* end of namespace ruby_eigen */
