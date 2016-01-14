%define DENSE_MATRIX_Common_Methods(TYPE, V_TYPE, s_type)

  RubyEigen:: ## V_TYPE col(int);
  RubyEigen:: ## V_TYPE row(int);

  int cols();
  int rows();

  V_TYPE diagonal();
  TYPE diagonal(int);

  TYPE inverse();
  s_type determinant();
  double norm();
  double operatorNorm();

  s_type sum();
  s_type prod();

  void normalize();

  TYPE transpose();
  TYPE conjugate();
  TYPE reverse();
  TYPE replicate(int, int);

  RubyEigen::VectorXcd eigenvalues();

  bool isDiagonal();
  bool isIdentity();
  bool isLowerTriangular();
  bool isLowerTriangular(double);
  bool isUpperTriangular();
  bool isUpperTriangular(double);

  TYPE middleCols(int, int);
  TYPE middleRows(int, int);

  RubyEigen::PartialPivLU<RubyEigen:: ## TYPE> lu();

  RubyEigen::LDLT<RubyEigen:: ## TYPE> ldlt();
  RubyEigen::LLT<RubyEigen:: ## TYPE> llt();

  %extend {

    void __set_col__(int i, const std::vector<s_type> &v){
      (*self).col(i) = Eigen:: ## V_TYPE ## ::Map(v.data(), v.size());
    }

    void __set_row__(int i, const std::vector<s_type> &v){
      (*self).row(i) = Eigen:: ## V_TYPE ## ::Map(v.data(), v.size());
    }

    RubyEigen:: ## TYPE __get_block__(int a, int b, int c, int d) {
      return (*$self).block(a, b, c, d);
    }

    void __set_block__(int a, int b, int c, int d, RubyEigen:: ## TYPE & m) {
      (*$self).block(a, b, c, d) = m;
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

    s_type __getitem__(int i, int j) {
      return (*$self)(i, j);
    }

    void __setitem__(int i, int j, s_type c) {
      (*$self)(i, j) = c;
    }
 
    TYPE triu() {
      return (*$self).triangularView<Eigen::Upper>();
    }

    TYPE tril() {
      return (*$self).triangularView<Eigen::Lower>();
    }

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
