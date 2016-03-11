namespace RubyEigen {
  typedef FullPivLU<MatrixXd> FullPivLUDouble;
  typedef FullPivLU<MatrixXcd> FullPivLUComplex;
  typedef PartialPivLU<MatrixXd> PartialPivLUDouble;
  typedef FullPivHouseholderQR<MatrixXd> FullPivHouseholderQRDouble;
  typedef FullPivHouseholderQR<MatrixXcd> FullPivHouseholderQRComplex;
  typedef JacobiSVD<MatrixXd> JacobiSVDDouble;
  typedef JacobiSVD<MatrixXcd> JacobiSVDComplex;
  typedef LDLT<MatrixXd>  LDLTDouble;
  typedef LDLT<MatrixXcd> LDLTComplex;
  typedef LLT<MatrixXd>   LLTDouble;
  typedef LLT<MatrixXcd>  LLTComplex;
};
