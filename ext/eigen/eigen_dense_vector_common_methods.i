%define DENSE_VECTOR_Common_Methods(TYPE, M_TYPE, s_type)

  bool isOrthogonal(TYPE& v);
  bool isOrthogonal(TYPE& v, double);
  double squaredNorm();
  double stableNorm();

  TYPE segment(int i, int len);

  %extend {

    s_type __getitem__(int i) {
      return (*$self)(i);
    }

    void __setitem__(int i, s_type c) {
      (*$self)(i) = c;
    }

    RubyEigen:: ## TYPE __get_segment__(int i, int len) {
      return (*$self).segment(i, len);
    }

    void __set_segment__(int i, int len, const std::vector<s_type> &v) {
      (*$self).segment(i, len) = Eigen:: ## TYPE ## ::Map(v.data(), v.size());
    }

    void __set_segment__(int i, int len, RubyEigen:: ## TYPE &v) {
      (*$self).segment(i, len) = v;
    }

    void __set_segment__(int i, int len, RubyEigen:: ## M_TYPE &v) {
      (*$self).segment(i, len) = v;
    }

    std::string to_s() {
      std::ostrstream s;
      s << (*$self) << std::ends;
      return s.str();
    }

  }

%enddef
