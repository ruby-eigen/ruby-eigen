#ifndef RUBYEIGEN_GC_HPP
#define RUBYEIGEN_GC_HPP

#include "rubyeigen_gc.h"
#include <climits>

static size_t rubyeigen_gc_count = 0;

size_t rubyeigen_gc_get_count() {
  return rubyeigen_gc_count;
}

void rubyeigen_gc_reset_count() {
  rubyeigen_gc_count = 0;
}

void rubyeigen_gc_add_count(size_t sz) {
  const size_t max_size = (size_t)-1;
  if(max_size - rubyeigen_gc_count > sz ) {
    rubyeigen_gc_count += sz;
  } else if( sz > rubyeigen_gc_count ) {
    rubyeigen_gc_count = sz;
  }
}

#endif
