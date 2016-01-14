require "test/unit"
require "eigen"

class TestEigen < Test::Unit::TestCase

  def test_eigen
    m = Eigen::MatrixDouble.new(2,2)
    m[1,0] = 2
    assert_equal(m[1,0], 2)
    assert m.eigenvalues()[0].is_a?(Complex)
  end

  def test_matrix
    m = Eigen::MatrixDouble.new(2,2)
    k = 79.2
    m[0,1] = k; m[1,1] = 2
    assert_equal(k, m.col(1)[0])

    m.col(1)[0] = 0
    assert_equal(k, m[0,1])
  end

  def test_matrix02
    m1 = Eigen::MatrixDouble.new(200,200)
    m1.setRandom
    m2 = Eigen::MatrixDouble.new(200,200)
    m2.setRandom
    m1 * m2
  end

  def test_matrix03
    m1 = Eigen::MatrixDouble.new(2,3)
    m2 = Eigen::MatrixDouble.new(4,5)
    assert_raise(Eigen::EigenRuntimeError){ m1*m2 }
  end

  def test_matrix04
    m = Eigen::MatrixDouble.new(2,2)
    m.setRandom
    m[0,1] = 1
    assert_equal(0, m.tril[0,1])
    assert_equal(m[1,0], m.tril[1,0])
  end

  def test_matrix05
    m = Eigen::MatrixDouble.new(2,2)

    m.setRandom
    lu = m.fullPivLu
    p, l, u, q = lu.p, lu.l, lu.u, lu.q
    assert m.isApprox(p.inverse * l * u * q.inverse)

    m.setConstant(1)
    lu = m.fullPivLu
    p, l, u, q = lu.p, lu.l, lu.u, lu.q
    assert m.isApprox(p.inverse * l * u * q.inverse)
  end

  def test_matrix06
    m = Eigen::MatrixDouble.new(2,2)
    m.setZero
    m.__set_col__(0, [1,2])
    m.__set_row__(0, [1,2])
    m = Eigen::MatrixDouble[[1,2], [3,4]]

    qr = m.fullPivHouseholderQR
    assert  ( m * qr.p ).isApprox( qr.q * qr.r )

    m.setRandom
    qr = m.fullPivHouseholderQR
    assert  ( m * qr.p ).isApprox( qr.q * qr.r )
    
    m.svd().matrixU 

  end

  def test_matrix07
    m = Eigen::MatrixDouble.new(1,2)
    v = Eigen::VectorDouble.new(2)
    m * v
    v * m

    vc = Eigen::VectorComplex.new(2)
    vc.setRandom
    vc.segment(0,1)
  end

  def test_matrix08
    m = Eigen::MatrixDouble.new(3,3)
    m.setOnes
    n = m.__get_block__(1,1,2,2)
    n[0,0] = 0
  end

  def test_vector01
    assert_nothing_raised{ Eigen::VectorDouble[1, 2, 3] }
  end

end
