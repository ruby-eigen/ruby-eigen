%define DENSE_MATRIX_Methods(TYPE, s_type)

  RubyEigen::rb_eigen_traits<s_type>::vector_type col(int);
  TYPE row(int);

  int cols();
  int rows();

  RubyEigen::rb_eigen_traits<s_type>::vector_type diagonal();
  TYPE diagonal(int);

  s_type determinant();
  double norm();

  s_type sum();
  s_type prod();

  TYPE transpose();
  TYPE reverse();
  TYPE replicate(int, int);

  bool isDiagonal();
  bool isIdentity();
  bool isLowerTriangular();
  bool isLowerTriangular(double);
  bool isUpperTriangular();
  bool isUpperTriangular(double);

  TYPE middleCols(int, int);
  TYPE middleRows(int, int);

  %extend {

    std::vector< s_type > __get_row_array__(int i) {
      std::vector< s_type > v((*$self).cols());
      RubyEigen::rb_eigen_traits<s_type>::vector_type::Map(v.data(), v.size()) = (*$self).row(i);
      return v;
    }

    void __set_col__(int i, const std::vector<s_type> &v){
      (*self).col(i) = RubyEigen::rb_eigen_traits<s_type>::vector_type::Map(v.data(), v.size());
    }

    void __set_row__(int i, const std::vector<s_type> &v){
      (*self).row(i) = RubyEigen::rb_eigen_traits<s_type>::vector_type::Map(v.data(), v.size());
    }

    RubyEigen::rb_eigen_traits<s_type>::matrix_type __get_block__(int i, int j, int rows, int cols) {
      return (*$self).block(i, j, rows, cols);
    }

    std::string to_s() {
      std::ostrstream s;
      s << (*$self) << std::ends;
      return s.str();
    }

    s_type __get_item__(int i, int j) {
      return (*$self)(i, j);
    }

    void __setitem__(int i, int j, s_type c) {
      (*$self)(i, j) = c;
    }

    void __setitem__(int i, int j, RubyEigen:: ## TYPE & m) {
      (*$self).block(i, j, m.rows(), m.cols()) = m;
    }

    TYPE triu() {
      return (*$self).triangularView<Eigen::Upper>();
    }

    TYPE tril() {
      return (*$self).triangularView<Eigen::Lower>();
    }

  }

%enddef

%define DENSE_MATRIX_RC_Methods(TYPE, V_TYPE, s_type)

  void normalize();
  s_type operatorNorm();

  TYPE inverse();
  RubyEigen::Matrix<RubyEigen::Matrix<std::complex<s_type>, RubyEigen::Dynamic, RubyEigen::Dynamic>::Scalar, RubyEigen::Dynamic, 1> eigenvalues();
  TYPE conjugate();

  RubyEigen::PartialPivLU<RubyEigen:: ## TYPE > lu();

  RubyEigen::LDLT<RubyEigen:: ## TYPE > ldlt();
  RubyEigen::LLT<RubyEigen:: ## TYPE > llt();

  %extend {
    RubyEigen::FullPivLU<TYPE> fullPivLu() {
      return (*self).fullPivLu();
    }

    RubyEigen::FullPivHouseholderQR<TYPE> fullPivHouseholderQR() {
      return RubyEigen::FullPivHouseholderQR<RubyEigen::TYPE >(*$self);
    }

    RubyEigen::JacobiSVD<TYPE> svd() {
      return RubyEigen::JacobiSVD<RubyEigen:: ## TYPE >(*$self, Eigen::ComputeFullU | Eigen::ComputeFullV);
    }
  }
%enddef

