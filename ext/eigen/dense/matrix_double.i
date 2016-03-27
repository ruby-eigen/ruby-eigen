namespace RubyEigen {

  // %rename(MatrixDouble) MatrixXd; 

  // %alias MatrixXd::operator== "__eq__";
  // %alias MatrixXd::array "cmatrix,cm";

  template<typename T, typename D1, typename D2>
  class Matrix {
  public:
    Matrix(int, int);
    ~Matrix();

  /* real matrix only */
    Matrix cwiseAbs();
    Matrix cwiseAbs2();

    Matrix cwiseMax(Matrix &m);
    Matrix cwiseMax(T);
    Matrix cwiseMin(Matrix &m);
    Matrix cwiseMin(T);

    T maxCoeff();
    T minCoeff();

    RubyEigen::Array<T, D1, D2> array();
    
    RubyEigen::Matrix real();
#define VectorTinMatrix Matrix<RubyEigen::Matrix<T, RubyEigen::Dynamic, RubyEigen::Dynamic>::Scalar, RubyEigen::Dynamic, 1>
#define MatrixTinMatrix Matrix<T, RubyEigen::Dynamic, RubyEigen::Dynamic>
    DENSE_MATRIX_VECTOR_Common_Methods(Matrix, VectorTinMatrix, T) 
    DENSE_MATRIX_Methods(Matrix, VectorTinMatrix, T) 
    DENSE_MATRIX_RC_Methods(MatrixTinMatrix, VectorTinMatrix, T) 

  Matrix operator*(const RubyEigen::Transpose<Matrix>&); 

  %extend {
    RubyEigen::Block< RubyEigen::Matrix<T, D1, D2> > __ref__(int i, int j, int rows, int cols) {
      return (*$self).block(i, j, rows, cols);
    }
  }
    
}; /* end class MatrixXd */
  %template(MatrixDouble) Matrix<double, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(MatrixFloat)  Matrix<float, RubyEigen::Dynamic, RubyEigen::Dynamic>;

  
class MatrixXd {
public:
  MatrixXd(int, int);
  ~MatrixXd();

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

  MatrixXd operator*(const RubyEigen::Transpose<MatrixXd>&);

  %extend {
    RubyEigen::Block< RubyEigen::MatrixXd > __ref__(int i, int j, int rows, int cols) {
      return (*$self).block(i, j, rows, cols);
    }
  }

  };  /* end class MatrixXd */

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
