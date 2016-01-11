require 'mkmf'
$CXXFLAGS = ($CXXFLAGS || "") + " -O2 -Wall "
dir_config('eigen')
have_library("c++") or have_library("stdc++")
create_makefile('eigen')
