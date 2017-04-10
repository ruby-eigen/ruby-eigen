namespace RubyEigen {

template<typename T, typename D1, typename D2>
class Matrix {
public:

  typedef T Scalar;


%typemap(ret) Matrix<T, D1, D2> %{
  RubyEigen::adjust_memory_usage(&$1);
%}

  Matrix(size_t, size_t);
  ~Matrix();

%rename("abs") cwiseAbs;
  Matrix cwiseAbs();

  RubyEigen::Matrix real();

  // define common methods
  DefineMVCommonMethods(Matrix, T)
  DefineFloatMVMethods(Matrix, T)

  RubyEigen::rb_eigen_traits<T>::vector_type col(size_t);
  Matrix row(size_t);

  size_t cols();
  size_t rows();

  RubyEigen::rb_eigen_traits<T>::vector_type diagonal();
  Matrix diagonal(int);

  T determinant();
  double norm();

  Matrix transpose();

  bool isDiagonal();
  bool isIdentity();
  bool isLowerTriangular();
  bool isLowerTriangular(double);
  bool isUpperTriangular();
  bool isUpperTriangular(double);

  %rename("dot") operator*;
  Matrix operator*(const Matrix&);
  rb_eigen_traits<T>::vector_type operator*(const rb_eigen_traits<T>::vector_type &);
  Matrix operator*(const T&);
  Matrix operator*(const RubyEigen::Transpose<Matrix>&); 

  ExtendMatrixForNArray(T)

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


  // elementwise operations
  ExtendForCwiseOp(Matrix)

  T operatorNorm();

  // decomposition and solving methods
  Matrix inverse();
  RubyEigen::Matrix<std::complex< RubyEigen::rb_eigen_traits<T>::float_type >, RubyEigen::Dynamic, 1> eigenvalues();
  Matrix conjugate();

  %rename("partial_piv_lu") lu;
  RubyEigen::PartialPivLU<RubyEigen::rb_eigen_traits<T>::matrix_type > lu();

  %rename("cholesky_ldlt") ldlt;
  %rename("cholesky_llt") llt;
  RubyEigen::LDLT<RubyEigen::rb_eigen_traits<T>::matrix_type > ldlt();
  RubyEigen::LLT<RubyEigen::rb_eigen_traits<T>::matrix_type > llt();

  %extend {

    %newobject eigen_solver;
    RubyEigen::ComplexEigenSolver<RubyEigen::rb_eigen_traits<T>::matrix_type>* complex_eigen_solver() {
      return new RubyEigen::ComplexEigenSolver<RubyEigen::rb_eigen_traits<T>::matrix_type>(*$self);
    }

    RubyEigen::FullPivLU<RubyEigen::rb_eigen_traits<T>::matrix_type> full_piv_lu() {
      return (*self).fullPivLu();
    }

    %newobject full_piv_householder_qr;
    RubyEigen::FullPivHouseholderQR<RubyEigen::rb_eigen_traits<T>::matrix_type>* full_piv_householder_qr() {
      return new RubyEigen::FullPivHouseholderQR<RubyEigen::rb_eigen_traits<T>::matrix_type>(*$self);
    }

    %newobject jacobi_svd;
    RubyEigen::JacobiSVD<RubyEigen::rb_eigen_traits<T>::matrix_type>* jacobi_svd() {
      return new RubyEigen::JacobiSVD<RubyEigen::rb_eigen_traits<T>::matrix_type>(*$self, Eigen::ComputeFullU | Eigen::ComputeFullV);
    }
  }

}; // class Matrix

  // floor, round, and ceil
  ExtendRealFloatMatrixForCwiseOp(double)
  ExtendRealFloatMatrixForCwiseOp(float)

  // max and min
  ExtendRealMatrixCwiseOp(double)
  ExtendRealMatrixCwiseOp(float)

  %template(DFloatMatrix) Matrix<double, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(SFloatMatrix) Matrix<float,  RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(DComplexMatrix) Matrix<std::complex<double>, RubyEigen::Dynamic, RubyEigen::Dynamic>;
  %template(SComplexMatrix) Matrix<std::complex<float>,  RubyEigen::Dynamic, RubyEigen::Dynamic>;

}; /* end of namespace RubyEigen */
