namespace RubyEigen {

template<typename T, typename D1, typename D2>
class Matrix {
public:
  Matrix(int, int);
  ~Matrix();

  Matrix cwiseAbs();
  Matrix cwiseAbs2();

  /* real matrix only */
  //  T maxCoeff();
  //  T minCoeff();

  RubyEigen::Matrix real();

  DENSE_MATRIX_VECTOR_Common_Methods(Matrix, T) 
  DENSE_MATRIX_Methods(Matrix, T) 
    //    DENSE_MATRIX_RC_Methods(MatrixTinMatrix, VectorTinMatrix, T) 


  %rename("dot") operator*;
  Matrix operator*(const Matrix&);
  rb_eigen_traits<T>::vector_type operator*(const rb_eigen_traits<T>::vector_type &);
  Matrix operator*(const T&);
  Matrix operator*(const RubyEigen::Transpose<Matrix>&); 

  %extend {
    RubyEigen::Block< RubyEigen::Matrix<T, D1, D2> > __ref__(int i, int j, int rows, int cols) {
      return (*$self).block(i, j, rows, cols);
    }
  }

}; /* end class MatrixDouble */

  %template(MatrixDouble) Matrix<double, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(MatrixFloat)  Matrix<float, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(MatrixDComplex) Matrix<std::complex<double>, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(MatrixSComplex) Matrix<std::complex<float>,  RubyEigen::Dynamic, RubyEigen::Dynamic>;

class MatrixDoubleRef {
public:
  MatrixDoubleRef(RubyEigen::MatrixDouble&, int, int, int, int);
  ~MatrixDoubleRef();

  /* real matrix only */
  MatrixDouble cwiseAbs();
  MatrixDouble cwiseAbs2();

  double maxCoeff();
  double minCoeff();

  RubyEigen::MatrixDouble real();

  //  DENSE_MATRIX_VECTOR_Common_Methods(MatrixDouble, VectorXd, double)
  //  DENSE_MATRIX_Methods(MatrixDouble, VectorXd, double)
  //  DENSE_MATRIX_RC_Methods(MatrixDouble, VectorXd, double)
};


}; /* end of namespace ruby_eigen */
