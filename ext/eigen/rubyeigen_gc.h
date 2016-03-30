#ifndef RUBYEIGEN_GC_H
#define RUBYEIGEN_GC_H
void rb_gc();
void rubyeigen_gc_if_needed(size_t sz);
#endif
