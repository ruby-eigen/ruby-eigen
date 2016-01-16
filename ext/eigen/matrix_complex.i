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

};

};
