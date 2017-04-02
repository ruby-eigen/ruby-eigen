  bool isOrthogonal(Matrix& v);
  bool isOrthogonal(Matrix& v, double);
  double squaredNorm();
  double stableNorm();

  Matrix segment(int i, int len);

  %extend {

    T __getitem__(int i) {
      return (*$self)(i);
    }

    void __setitem__(int i, T c) {
      (*$self)(i) = c;
    }

    std::vector< T > to_a() {
      std::vector< T > v((*$self).rows());
      RubyEigen::rb_eigen_traits<T>::vector_type::Map(v.data(), v.size()) = (*$self);
      return v;
    }

    RubyEigen::rb_eigen_traits<T>::vector_type __get_segment__(int i, int len) {
      return (*$self).segment(i, len);
    }

    void __set_segment__(int i, int len, const std::vector<T> &v) {
      (*$self).segment(i, len) = RubyEigen::rb_eigen_traits<T>::vector_type::Map(v.data(), v.size());
    }

    void __set_segment__(int i, int len, RubyEigen::rb_eigen_traits<T>::vector_type &v) {
      (*$self).segment(i, len) = v;
    }

    void __set_segment__(int i, int len, RubyEigen::rb_eigen_traits<T>::matrix_type &v) {
      (*$self).segment(i, len) = v;
    }

    std::string to_s() {
      std::ostrstream s;
      s << (*$self) << std::ends;
      return s.str();
    }

  }
