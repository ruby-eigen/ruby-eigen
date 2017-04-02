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

    static RubyEigen::Matrix from_narray(VALUE na) {
      if (!IsNArray(na)) {
        rb_raise(rb_eArgError, "Numo::NArray expected");
      }
      if ( !rb_obj_is_kind_of(na, RubyEigen::narray_traits<T>::type()) ) {
        rb_raise(rb_eArgError, "Numo::NArray type not matched");
      }
      if (RNARRAY_NDIM(na)!=2) {
        rb_raise(rb_eArgError, "NArray#ndim == 2 expected");
      } else {
        size_t* shp = RNARRAY_SHAPE(na);
        size_t rows = shp[0];
        size_t cols = shp[1];
        char*  data = RNARRAY_DATA_PTR(na);
        RubyEigen::adjust_memory_usage(rows*cols*sizeof(T));

        // The storage order of Eigen is a column-major by default. The one of NArray is a row-major.
        // So we have to transpose here.
        RubyEigen::Map<RubyEigen::Matrix<T, RubyEigen::Dynamic, RubyEigen::Dynamic> > tmp((T*) data, cols, rows);
        return tmp.transpose();
      }
    }

    VALUE to_narray() {
      size_t rows     = $self->rows();
      size_t cols     = $self->cols();
      size_t len      = rows*cols;
      size_t shape[2] = {rows, cols};
      VALUE  na       = rb_narray_new(RubyEigen::narray_traits<T>::type(), 2, shape);
      char*  data     = (char *) xmalloc(len*sizeof(T));
      RNARRAY_DATA_PTR(na) = data;

      // The storage order of Eigen is a column-major by default. The one of NArray is a row-major.
      // So we have to transpose here.
      RubyEigen::Map<RubyEigen::Matrix<T, RubyEigen::Dynamic, RubyEigen::Dynamic> >((T*) data, cols, rows) = $self->transpose();
      return na;
    }

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
