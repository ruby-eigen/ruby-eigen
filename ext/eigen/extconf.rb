require 'mkmf'
eigen3_opt = dir_config('eigen')
have_library("c++") or have_library("stdc++")

unless eigen3_opt[0]
  eigen_path = File.join( File.dirname(File.expand_path(__FILE__)), "eigen")
  find_header("Eigen/src/misc/blas.h", eigen_path)
end
have_func("rb_gc_adjust_memory_usage")

$CXXFLAGS = ($CXXFLAGS || "") + " -std=c++11 "
create_makefile('eigen/eigen')
