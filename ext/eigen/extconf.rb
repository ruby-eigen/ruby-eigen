require 'mkmf'
eigen_opt = dir_config('eigen')
have_library("c++") or have_library("stdc++")

gems = Gem::Specification.find_all_by_name("numo-narray")
if gems.size > 1
  raise "multiple numo-narray gems found"
end
find_header("numo/narray.h", File.join(gems[0].gem_dir, "lib/numo/") )

unless eigen_opt[0]
  eigen_path = File.join( File.dirname(File.expand_path(__FILE__)), "eigen")
  find_header("Eigen/src/misc/blas.h", eigen_path)
end
have_func("rb_gc_adjust_memory_usage")

$CXXFLAGS = ($CXXFLAGS || "") + " -std=c++11 "
create_makefile('eigen/eigen')
