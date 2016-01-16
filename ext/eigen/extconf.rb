require 'mkmf'
eigen3_opt = dir_config('eigen')
have_library("c++") or have_library("stdc++")

eigen3_path = File.join( File.dirname(File.expand_path(__FILE__)), "eigen3")

$CXXFLAGS = ($CXXFLAGS || "") + " -I#{eigen3_path} -O2 -Wall "
create_makefile('eigen/eigen')


# a monkey patch to make cc_command into cxx_command
# module MakeMakefile
#   def cc_command(opt="")
#     conf = RbConfig::CONFIG.merge('hdrdir' => $hdrdir.quote, 'srcdir' => $srcdir.quote,
#                                   'arch_hdrdir' => $arch_hdrdir.quote,
#                                   'top_srcdir' => $top_srcdir.quote)
#     RbConfig::expand("$(CXX) #$INCFLAGS #$CPPFLAGS #$CXXFLAGS #$ARCH_FLAG #{opt} -c #{CONFTEST_C}",
#                      conf)
#   end
# end

# guess where eigen3 headers unless --with-eigen-include given.

# unless eigen3_opt[0]
#   case RbConfig::CONFIG["includedir"]
#   when /(.*)Cellar\/ruby((?!Cellar).)+\z/   # Homebrew
#     eigen3_path = File.join($1, "include/eigen3")
#   when "/usr/local/include"                 # Ubuntu
#     eigen3_path = "/usr/include/eigen3"
#   else                                      # MacPorts?
#     eigen3_path = File.join(RbConfig::CONFIG["includedir"], "eigen3")
#   end

#   if try_compile("#include <Eigen/Core>", "-I" + eigen3_path)
#       $CXXFLAGS = ($CXXFLAGS || "") + " -I#{eigen3_path} "
#   end
# end
