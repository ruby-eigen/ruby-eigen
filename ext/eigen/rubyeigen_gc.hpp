#ifndef RUBYEIGEN_GC_HPP
#define RUBYEIGEN_GC_HPP

#include "rubyeigen_gc.h"

void rubyeigen_gc_if_needed(size_t sz) {
  static size_t count = 0;
  count += sz;
  if(count > 67108864) {
    rb_gc();
    count = 0;
  }
}

#endif
