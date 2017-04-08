%define ExtendMatrixForNArray(s_type)
%extend {
    static RubyEigen::Matrix from_narray(VALUE na) {
      if (!IsNArray(na)) {
        rb_raise(rb_eArgError, "Numo::NArray expected");
      }
      if ( !rb_obj_is_kind_of(na, RubyEigen::narray_traits<s_type>::type()) ) {
        rb_raise(rb_eArgError, "Numo::NArray type not matched");
      }
      if (RNARRAY_NDIM(na)!=2) {
        rb_raise(rb_eArgError, "NArray#ndim == 2 expected");
      } else {
        size_t* shp = RNARRAY_SHAPE(na);
        size_t rows = shp[0];
        size_t cols = shp[1];
        char*  data = RNARRAY_DATA_PTR(na);
        RubyEigen::adjust_memory_usage(rows*cols*sizeof(s_type));

        // The storage order of Eigen is a column-major by default. The one of NArray is a row-major.
        // So we have to transpose here.
        RubyEigen::Map<RubyEigen::Matrix<s_type, RubyEigen::Dynamic, RubyEigen::Dynamic> > tmp((s_type*) data, cols, rows);
        return tmp.transpose();
      }
    }

    VALUE to_narray() {
      size_t rows     = $self->rows();
      size_t cols     = $self->cols();
      size_t len      = rows*cols;
      size_t shape[2] = {rows, cols};
      VALUE  na       = rb_narray_new(RubyEigen::narray_traits<s_type>::type(), 2, shape);
      char*  data     = (char *) xmalloc(len*sizeof(s_type));
      RNARRAY_DATA_PTR(na) = data;

      // The storage order of Eigen is a column-major by default. The one of NArray is a row-major.
      // So we have to transpose here.
      RubyEigen::Map<RubyEigen::Matrix<s_type, RubyEigen::Dynamic, RubyEigen::Dynamic> >((s_type*) data, cols, rows) = $self->transpose();
      return na;
    }
} // %extend
%enddef


%define ExtendRealFloatMatrixForCwiseOp(s_type)
%extend Matrix<s_type, RubyEigen::Dynamic, RubyEigen::Dynamic> {

  Matrix<s_type, RubyEigen::Dynamic, RubyEigen::Dynamic> ceil() {
    return $self->array().ceil();
  }

  Matrix<s_type, RubyEigen::Dynamic, RubyEigen::Dynamic> floor() {
    return $self->array().floor();
  }

  Matrix<s_type, RubyEigen::Dynamic, RubyEigen::Dynamic> round() {
    return $self->array().round();
  }

}
%enddef

%define ExtendRealMatrixCwiseOp(s_type)
%extend Matrix<s_type, RubyEigen::Dynamic, RubyEigen::Dynamic> {

  s_type max() {
    return $self->maxCoeff();
  }

  s_type min() {
    return $self->minCoeff();
  }

}
%enddef
