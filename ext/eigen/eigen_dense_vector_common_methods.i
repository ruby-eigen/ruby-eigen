%define DENSE_VECTOR_Common_Methods(TYPE, s_type)

  bool isOrthogonal(TYPE& v);
  bool isOrthogonal(TYPE& v, double);
  double squaredNorm();
  double stableNorm();

  TYPE segment(int, int);

  %extend {

    s_type __getitem__(int i) {
      return (*$self)(i);
    }

    void __setitem__(int i, s_type c) {
      (*$self)(i) = c;
    }

  }

%enddef
