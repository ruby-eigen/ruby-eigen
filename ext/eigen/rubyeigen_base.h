/* To avoid contaminating Eigen namespace, we use RubyEigen instead of Eigen. */
namespace RubyEigen {

  typedef RubyEigen::Matrix<double, RubyEigen::Dynamic, RubyEigen::Dynamic> MatrixDouble;
  typedef RubyEigen::Matrix<float, RubyEigen::Dynamic, RubyEigen::Dynamic> MatrixFloat;
  typedef RubyEigen::Matrix<std::complex<double>, RubyEigen::Dynamic, RubyEigen::Dynamic> MatrixComplex;
  typedef RubyEigen::Matrix<std::complex<float>, RubyEigen::Dynamic, RubyEigen::Dynamic> MatrixComplexFloat;

  typedef RubyEigen::Array<double, RubyEigen::Dynamic, RubyEigen::Dynamic> ArrayXXd;
 
  /*
     By redefining VectorXd and VectorXcd in SWIG scope, SWIG can interpret what the templates are.
     The following templates appear in some decomposition classes.
  */
  typedef RubyEigen::Matrix<RubyEigen::MatrixDouble::Scalar, RubyEigen::Dynamic, 1> VectorXd;
  typedef RubyEigen::Matrix<RubyEigen::MatrixComplex::Scalar, RubyEigen::Dynamic, 1> VectorXcd;
  typedef RubyEigen::Matrix<RubyEigen::MatrixXi::Scalar, RubyEigen::Dynamic, 1> VectorXi;

  typedef RubyEigen::Block<RubyEigen::MatrixDouble> MatrixDoubleRef;
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
};
