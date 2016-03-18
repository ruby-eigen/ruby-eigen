namespace RubyEigen {
  class EigenRuntimeError : public std::runtime_error {
  public:
    EigenRuntimeError(const std::string& cause) 
      : std::runtime_error(cause) {}
  };
};

VALUE rb_eEigenRuntimeError;

/* DONOT use rb_raise here. eigen_assert is called inside the functions
   of eigen library in C++. Calling rb_raise will cause deconstructor issues. */
#undef eigen_assert
#define eigen_assert(x) do {\
 if(!Eigen::internal::copy_bool(x)) throw (RubyEigen::EigenRuntimeError(EIGEN_MAKESTRING(x))); } while(false)
