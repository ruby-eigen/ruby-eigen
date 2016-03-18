%exception {
  try {
    $action
  }
  catch (const RubyEigen::EigenRuntimeError &e) {
    /* this rb_raise is called inside SWIG functions. That's ok. */
    rb_raise(rb_eEigenRuntimeError, "%s", e.what());
  }
}


%init %{
  rb_eEigenRuntimeError = rb_define_class_under(mEigen, "EigenRuntimeError", rb_eRuntimeError);
%}
