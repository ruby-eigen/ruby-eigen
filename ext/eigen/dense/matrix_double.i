namespace RubyEigen {

template<typename T, typename D1, typename D2>
class Matrix {
public:

  typedef T Scalar;

  Matrix(int, int);
  ~Matrix();

  Matrix cwiseAbs();
  Matrix cwiseAbs2();

  /* real matrix only */
  //  T maxCoeff();
  //  T minCoeff();

  RubyEigen::Matrix real();

  DENSE_MATRIX_VECTOR_Common_Methods(Matrix, T) 

  RubyEigen::rb_eigen_traits<T>::vector_type col(int);
  Matrix row(int);

  int cols();
  int rows();

  RubyEigen::rb_eigen_traits<T>::vector_type diagonal();
  Matrix diagonal(int);

  T determinant();
  double norm();

  T sum();
  T prod();

  Matrix transpose();
  Matrix reverse();
  Matrix replicate(int, int);

  bool isDiagonal();
  bool isIdentity();
  bool isLowerTriangular();
  bool isLowerTriangular(double);
  bool isUpperTriangular();
  bool isUpperTriangular(double);

  Matrix middleCols(int, int);
  Matrix middleRows(int, int);

  %rename("dot") operator*;
  Matrix operator*(const Matrix&);
  rb_eigen_traits<T>::vector_type operator*(const rb_eigen_traits<T>::vector_type &);
  Matrix operator*(const T&);
  Matrix operator*(const RubyEigen::Transpose<Matrix>&); 

  %extend {

    std::vector< T > __get_row_array__(int i) {
      std::vector< T > v((*$self).cols());
      RubyEigen::rb_eigen_traits<T>::vector_type::Map(v.data(), v.size()) = (*$self).row(i);
      return v;
    }

    void __set_col__(int i, const std::vector<T> &v){
      (*self).col(i) = RubyEigen::rb_eigen_traits<T>::vector_type::Map(v.data(), v.size());
    }

    void __set_row__(int i, const std::vector<T> &v){
      (*self).row(i) = RubyEigen::rb_eigen_traits<T>::vector_type::Map(v.data(), v.size());
    }

    RubyEigen::rb_eigen_traits<T>::matrix_type __get_block__(int i, int j, int rows, int cols) {
      return (*$self).block(i, j, rows, cols);
    }

    std::string to_s() {
      std::ostrstream s;
      s << (*$self) << std::ends;
      return s.str();
    }

    T __get_item__(int i, int j) {
      return (*$self)(i, j);
    }

    void __setitem__(int i, int j, T c) {
      (*$self)(i, j) = c;
    }

    void __setitem__(int i, int j, const RubyEigen::rb_eigen_traits<T>::matrix_type & m) {
      (*$self).block(i, j, m.rows(), m.cols()) = m;
    }

    Matrix triu() {
      return (*$self).triangularView<Eigen::Upper>();
    }

    Matrix tril() {
      return (*$self).triangularView<Eigen::Lower>();
    }

    RubyEigen::Block< RubyEigen::Matrix<T, D1, D2> > __ref__(int i, int j, int rows, int cols) {
      return (*$self).block(i, j, rows, cols);
    }
  }

  void normalize();
  T operatorNorm();

  Matrix inverse();
  RubyEigen::Matrix<std::complex< RubyEigen::rb_eigen_traits<T>::float_type >, RubyEigen::Dynamic, 1> eigenvalues();
  Matrix conjugate();

  RubyEigen::PartialPivLU<RubyEigen::rb_eigen_traits<T>::matrix_type > lu();

  RubyEigen::LDLT<RubyEigen::rb_eigen_traits<T>::matrix_type > ldlt();
  RubyEigen::LLT<RubyEigen::rb_eigen_traits<T>::matrix_type > llt();

  %extend {
    RubyEigen::FullPivLU<RubyEigen::rb_eigen_traits<T>::matrix_type> fullPivLu() {
      return (*self).fullPivLu();
    }

    RubyEigen::FullPivHouseholderQR<RubyEigen::rb_eigen_traits<T>::matrix_type> fullPivHouseholderQR() {
      return RubyEigen::FullPivHouseholderQR<RubyEigen::rb_eigen_traits<T>::matrix_type>(*$self);
    }

    RubyEigen::JacobiSVD<RubyEigen::rb_eigen_traits<T>::matrix_type> svd() {
      return RubyEigen::JacobiSVD<RubyEigen::rb_eigen_traits<T>::matrix_type>(*$self, Eigen::ComputeFullU | Eigen::ComputeFullV);
    }
  }

}; // class Matrix

  %template(DFloatMatrix) Matrix<double, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(SFloatMatrix) Matrix<float,  RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(DComplexMatrix) Matrix<std::complex<double>, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(SComplexMatrix) Matrix<std::complex<float>,  RubyEigen::Dynamic, RubyEigen::Dynamic>;

class DFloatMatrixRef {
public:
  DFloatMatrixRef(RubyEigen::DFloatMatrix&, int, int, int, int);
  ~DFloatMatrixRef();

  /* real matrix only */
  DFloatMatrix cwiseAbs();
  DFloatMatrix cwiseAbs2();

  double maxCoeff();
  double minCoeff();

  RubyEigen::DFloatMatrix real();

  //  DENSE_MATRIX_VECTOR_Common_Methods(MatrixDouble, VectorXd, double)
  //  DENSE_MATRIX_Methods(MatrixDouble, VectorXd, double)
  //  DENSE_MATRIX_RC_Methods(MatrixDouble, VectorXd, double)
};


}; /* end of namespace ruby_eigen */
