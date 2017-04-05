require 'mkmf'
eigen_opt = dir_config('eigen')
have_library("c++") or have_library("stdc++")

gems = Gem::Specification.find_all_by_name("numo-narray")
if gems.size > 1
  raise "multiple numo-narray gems found"
end
unless find_header("numo/narray.h", File.join(gems[0].gem_dir, "lib/numo/") )
  raise "numo-narray required"
end

unless eigen_opt[0]
  eigen_path = File.join( File.dirname(File.expand_path(__FILE__)), "eigen")
  find_header("Eigen/src/misc/blas.h", eigen_path)
end

have_func("rb_gc_adjust_memory_usage")

backend_flag = ""
if enable_config("blas", true)
 if have_library("OpenBLAS") or have_library("atlas")
   backend_flag += " -DEIGEN_USE_BLAS "
 end
end

if backend_flag == "" and enable_config("lapacke", true) and find_library("lapacke", nil, "/opt/local/lib/lapack/")
   have_framework("Accelerate")
   backend_flag += " -DEIGEN_USE_LAPACKE "
end

$CXXFLAGS = ($CXXFLAGS || "") + " -std=c++11 #{backend_flag} "
create_makefile('eigen/eigen')
