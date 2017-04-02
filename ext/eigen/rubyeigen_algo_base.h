namespace RubyEigen {
  typedef SparseQR<RubyEigen::DFloatSpMatrix, COLAMDOrdering<int> > DFloatSparseQR;
  typedef SparseQR<RubyEigen::SFloatSpMatrix, COLAMDOrdering<int> > SFloatSparseQR;

  typedef SparseLU<RubyEigen::DFloatSpMatrix, COLAMDOrdering<int> > DFloatSparseLU;
  typedef SparseLU<RubyEigen::SFloatSpMatrix, COLAMDOrdering<int> > SFloatSparseLU;
};
