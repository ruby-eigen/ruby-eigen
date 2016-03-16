namespace RubyEigen {
  typedef SparseQR<RubyEigen::SpMatrixDouble, COLAMDOrdering<int> > SparseQRDouble;
  typedef SparseQR<RubyEigen::SpMatrixFloat, COLAMDOrdering<int> > SparseQRFloat;

  typedef SparseLU<RubyEigen::SpMatrixDouble, COLAMDOrdering<int> > SparseLUDouble;
  typedef SparseLU<RubyEigen::SpMatrixFloat, COLAMDOrdering<int> > SparseLUFloat;
};
