namespace RubyEigen {

template<typename T, typename D1>
class Matrix<T, D1, 1> {
public:
  Matrix(int);
  ~Matrix();

  RubyEigen::Matrix real();

  %rename("dot") operator*;
  Matrix operator*(const Matrix&);
  rb_eigen_traits<T>::matrix_type operator*(const rb_eigen_traits<T>::matrix_type &);
  Matrix operator*(const T&);

  DENSE_MATRIX_VECTOR_Common_Methods(Matrix, T)

  bool isOrthogonal(Matrix& v);
  bool isOrthogonal(Matrix& v, double);
  double squaredNorm();
  double stableNorm();

  Matrix segment(int i, int len);

  %extend {

    static RubyEigen::Matrix from_narray(VALUE na) {
      if (!IsNArray(na)) {
        rb_raise(rb_eArgError, "Numo::NArray expected");
      }
      if (!rb_obj_is_kind_of(na, RubyEigen::narray_traits<T>::type()) ) {
        rb_raise(rb_eArgError, "Numo::NArray type not matched");
      }
      if (RNARRAY_NDIM(na)!=1) {
        rb_raise(rb_eArgError, "NArray#ndim == 1 expected");
      } else {
        size_t* shp = RNARRAY_SHAPE(na);
        size_t  len = shp[0];
        char*  data = RNARRAY_DATA_PTR(na);
        RubyEigen::adjust_memory_usage(len*sizeof(T));
        RubyEigen::Map<RubyEigen::Matrix<T, RubyEigen::Dynamic, 1> > tmp((T*) data, len);
        return tmp;
      }
    }

    VALUE to_narray() {
      size_t len      = $self->size();
      size_t shape[1] = {len};
      VALUE  na       = rb_narray_new(RubyEigen::narray_traits<T>::type(), 1, shape);
      char*  data     = (char *) xmalloc(len*sizeof(T));
      RNARRAY_DATA_PTR(na) = data;
      RubyEigen::Map<RubyEigen::Matrix<T, RubyEigen::Dynamic, 1> >((T*) data, len) = *$self;
      return na;
    }

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


};

  %template(DFloatVector) Matrix<double, RubyEigen::Dynamic, 1>;
  %template(VectorSFloat) Matrix<float,  RubyEigen::Dynamic, 1>;
  %template(VectorDComplex) Matrix<std::complex<double>, RubyEigen::Dynamic, 1>;
  %template(VectorSComplex) Matrix<std::complex<float>,  RubyEigen::Dynamic, 1>;


  // complex matrix only 
  //  RubyEigen::DFloatVector imag();
  //  RubyEigen::DFloatVector real();

}; /* end of namespace ruby_eigen */
