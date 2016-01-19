%define DENSE_MATRIX_Methods(TYPE, V_TYPE, s_type)

  RubyEigen:: ## V_TYPE col(int);
  TYPE row(int);

  int cols();
  int rows();

  V_TYPE diagonal();
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
      Eigen:: ## V_TYPE ## ::Map(v.data(), v.size()) = (*$self).row(i);
      return v;
    }

    void __set_col__(int i, const std::vector<s_type> &v){
      (*self).col(i) = Eigen:: ## V_TYPE ## ::Map(v.data(), v.size());
    }

    void __set_row__(int i, const std::vector<s_type> &v){
      (*self).row(i) = Eigen:: ## V_TYPE ## ::Map(v.data(), v.size());
    }

    RubyEigen:: ## TYPE __get_block__(int i, int j, int rows, int cols) {
      return (*$self).block(i, j, rows, cols);
    }

    RubyEigen:: ## TYPE getBottomLeftCorner(int i, int j) {
      return (*$self).bottomLeftCorner(i, j);
    }

    void setBottomLeftCorner(RubyEigen:: ## TYPE &m) {
      (*$self).bottomLeftCorner(m.rows(), m.cols()) = m;
    }

    RubyEigen:: ## TYPE getBottomRightCorner(int i, int j) {
      return (*$self).bottomRightCorner(i, j);
    }

    void setBottomRightCorner(RubyEigen:: ## TYPE &m) {
      (*$self).bottomRightCorner(m.rows(), m.cols()) = m;
    }

    RubyEigen:: ## TYPE getTopLeftCorner(int i, int j) {
      return (*$self).topLeftCorner(i, j);
    }

    void setTopLeftCorner(RubyEigen:: ## TYPE &m) {
      (*$self).topLeftCorner(m.rows(), m.cols()) = m;
    }

    RubyEigen:: ## TYPE getTopRightCorner(int i, int j) {
      return (*$self).topRightCorner(i, j);
    }

    void setTopRightCorner(RubyEigen:: ## TYPE &m) {
      (*$self).topRightCorner(m.rows(), m.cols()) = m;
    }

    TYPE __mul_n__(TYPE &a, TYPE &b, TYPE &c, TYPE &d){
      return (*$self) * a * b * c * d;
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
  double operatorNorm();

  TYPE inverse();
  RubyEigen::VectorXcd eigenvalues();
  TYPE conjugate();

  RubyEigen::PartialPivLU<RubyEigen:: ## TYPE> lu();

  RubyEigen::LDLT<RubyEigen:: ## TYPE> ldlt();
  RubyEigen::LLT<RubyEigen:: ## TYPE> llt();

  %extend {
    RubyEigen::FullPivLU<TYPE> fullPivLu() {
      return (*self).fullPivLu();
    }

    RubyEigen::FullPivHouseholderQR<TYPE> fullPivHouseholderQR() {
      return RubyEigen::FullPivHouseholderQR<RubyEigen::TYPE>(*$self);
    }

    RubyEigen::JacobiSVD<TYPE> svd() {
      return Eigen::JacobiSVD<Eigen:: ## TYPE>(*$self, Eigen::ComputeFullU | Eigen::ComputeFullV);
    }
  }
%enddef

