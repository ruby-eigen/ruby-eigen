namespace RubyEigen {

%rename(MatrixComplex) MatrixXcd;

%alias MatrixXcd::operator== "__eq__";

class MatrixXcd {
public:
  MatrixXcd(int, int);
  ~MatrixXcd();

  /* complex matrix only */
  RubyEigen::MatrixXd imag();

  RubyEigen::MatrixXd real();

  DENSE_MATRIX_VECTOR_Common_Methods(MatrixXcd, VectorXcd, std::complex<double>)
  DENSE_MATRIX_Methods(MatrixXcd, VectorXcd, std::complex<double>)
  DENSE_MATRIX_RC_Methods(MatrixXcd, VectorXcd, std::complex<double>)

  %extend {
    RubyEigen::Block< RubyEigen::MatrixXcd > __ref__(int i, int j, int rows, int cols) {
      return (*$self).block(i, j, rows, cols);
    }
  }

};

class MatrixComplexRef {
public:
  MatrixComplexRef(RubyEigen::MatrixXcd&, int, int, int, int);
  ~MatrixComplexRef();

  /* complex matrix only */
  RubyEigen::MatrixXd imag();

  RubyEigen::MatrixXd real();

  DENSE_MATRIX_VECTOR_Common_Methods(MatrixXcd, VectorXcd, std::complex<double>)
  DENSE_MATRIX_Methods(MatrixXcd, VectorXcd, std::complex<double>)
  DENSE_MATRIX_RC_Methods(MatrixXcd, VectorXcd, std::complex<double>)
};

};  /* end of namespace ruby_eigen */