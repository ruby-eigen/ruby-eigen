/* To avoid contaminating Eigen namespace, we use RubyEigen instead of Eigen. */
namespace RubyEigen {

  /*
     By redefining VectorXd and VectorXcd in SWIG scope, SWIG can interpret what the templates are.
     The following templates appear in some decomposition classes.
  */
  typedef RubyEigen::Matrix<RubyEigen::MatrixXd::Scalar, RubyEigen::Dynamic, 1> VectorXd;
  typedef RubyEigen::Matrix<RubyEigen::MatrixXcd::Scalar, RubyEigen::Dynamic, 1> VectorXcd;
  typedef RubyEigen::Matrix<RubyEigen::MatrixXi::Scalar, RubyEigen::Dynamic, 1> VectorXi;

  typedef RubyEigen::Block<RubyEigen::MatrixXd> MatrixDoubleRef;
  typedef RubyEigen::Block<RubyEigen::MatrixXcd> MatrixComplexRef;

  typedef Matrix<bool, Dynamic, Dynamic> MatrixBool;
  typedef Matrix<bool, Dynamic, 1> VectorBool;
  typedef Array<bool, Dynamic, Dynamic> CMatrixBool;
  typedef Array<bool, Dynamic, 1> CVectorBool;

  typedef SparseMatrix<double> SpMatrixDouble;
  typedef SparseMatrix<float>  SpMatrixFloat;
  typedef SparseMatrix<double>::InnerIterator SpMatrixDoubleIter;
  typedef SparseMatrix<float>::InnerIterator  SpMatrixFloatIter;

  typedef PermutationMatrix<RubyEigen::Dynamic, RubyEigen::Dynamic, int> PermutationMatrix;
  typedef Matrix<int, Dynamic, 1> PermutationIndices;

  typedef SparseQR<RubyEigen::SpMatrixDouble, COLAMDOrdering<int> > SparseQRDouble;
  typedef SparseQR<RubyEigen::SpMatrixFloat, COLAMDOrdering<int> > SparseQRFloat;

  typedef SparseLU<RubyEigen::SpMatrixDouble, COLAMDOrdering<int> > SparseLUDouble;
  typedef SparseLU<RubyEigen::SpMatrixFloat, COLAMDOrdering<int> > SparseLUFloat;

};
