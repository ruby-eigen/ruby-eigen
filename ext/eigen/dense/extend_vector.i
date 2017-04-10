%define ExtendVectorForNArray(T)
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
} // %extend
%enddef


%define ExtendRealFloatVectorCwiseOps(s_type)
%extend Matrix<s_type, RubyEigen::Dynamic, 1> {

  Matrix<s_type, RubyEigen::Dynamic, 1> ceil() {
    return $self->array().ceil();
  }

  Matrix<s_type, RubyEigen::Dynamic, 1> floor() {
    return $self->array().floor();
  }

  Matrix<s_type, RubyEigen::Dynamic, 1> round() {
    return $self->array().round();
  }

}
%enddef

%define ExtendRealVectorCwiseOps(s_type)
%extend Matrix<s_type, RubyEigen::Dynamic, 1> {

  s_type max() {
    return $self->maxCoeff();
  }

  s_type min() {
    return $self->minCoeff();
  }

}
%enddef
