%define DENSE_VECTOR_Common_Methods(TYPE, V_TYPE, s_type)

  bool isOrthogonal(V_TYPE& v);
  bool isOrthogonal(V_TYPE& v, double);
  double squaredNorm();
  double stableNorm();

  V_TYPE segment(int, int);

  %extend {

    s_type __getitem__(int i) {
      return (*$self)(i);
    }

    void __setitem__(int i, s_type c) {
      (*$self)(i) = c;
    }

  }

%enddef
