require "test/unit"
require "eigen"

class TestEigen < Test::Unit::TestCase
  include Eigen

  def test_eigen
    m = MatrixDouble.new(2,2)
    m[1,0] = 2
    assert_equal(m[1,0], 2)
    assert m.eigenvalues()[0].is_a?(Complex)
  end

  def test_matrix
    m = MatrixDouble.new(2,2)
    k = 79.2
    m[0,1] = k; m[1,1] = 2
    assert_equal(k, m.col(1)[0])

    m.col(1)[0] = 0
    assert_equal(k, m[0,1])
  end

  def test_matrix02
    m1 = MatrixDouble.new(200,200)
    m1.set_random
    m2 = MatrixDouble.new(200,200)
    m2.set_random
    m1.dot m2
  end

  def test_matrix03
    m1 = MatrixDouble.new(2,3)
    m2 = MatrixDouble.new(4,5)
    assert_raise(EigenRuntimeError){ m1.dot m2 }
  end

  def test_matrix04
    m = MatrixDouble.new(2,2)
    m.set_random
    m[0,1] = 1
    assert_equal(0, m.tril[0,1])
    assert_equal(m[1,0], m.tril[1,0])
  end

  def test_matrix05
    m = MatrixDouble.new(2,2)

    m.set_random
    lu = m.full_piv_lu
    p, l, u, q = lu.p, lu.l, lu.u, lu.q
    assert m.is_approx(p.inverse.dot l.dot u.dot q.inverse )

    m.set_constant(1)
    lu = m.full_piv_lu
    p, l, u, q = lu.p, lu.l, lu.u, lu.q
    assert m.is_approx(p.inverse.dot l.dot u.dot q.inverse)
  end

  def test_matrix06
    m = MatrixDouble.new(2,2)
    m.set_zero
    m.__set_col__(0, [1,2])
    m.__set_row__(0, [1,2])
    m = MatrixDouble[[1,2], [3,4]]

    qr = m.full_piv_householder_qr
    assert  ( m.dot qr.p ).is_approx( qr.q.dot qr.r )

    m.set_random
    qr = m.full_piv_householder_qr
    assert  ( m. dot qr.p ).is_approx( qr.q. dot qr.r )
    
    m.svd().matrix_u 

  end

  def test_matrix07
    m = MatrixDouble.new(1,2)
    v = VectorDFloat.new(2)
    m.dot v
    v.dot m

    vc = VectorDComplex.new(2)
    vc.set_random
    vc.segment(0,1)
  end

  def test_matrix09
    m = MatrixDouble.new(3,3)
    m.set_ones
    assert_equal(m.to_a, Array.new(3){ [1.0, 1.0, 1.0] })

    v = VectorDFloat[1,2,3]
    assert_equal(v.to_a, [1.0, 2.0, 3.0])
  end

  def test_get
    m1 = MatrixDouble.new(3,3)
    m1.set_ones
    assert_equal(MatrixDouble[[1,1],[1,1]],
                 m1[0..1,0..1])
    assert_equal(MatrixDouble[[1,1],[1,1],[1,1]],
                 m1[true,0..1])
    assert_equal(MatrixDouble[[1,1],[1,1],[1,1]],
                 m1[0..-1,0..1])
    assert_equal(MatrixDouble[[1,1,1],[1,1,1]],
                 m1[0..1,true])
    assert_equal(MatrixDouble[[1,1,1],[1,1,1]],
                 m1[0..1,0..-1])
  end

  def test_set
    m1 = MatrixDouble.new(3,3)
    m1.set_ones
    m1[0, 0] = MatrixDouble[[0,0],[0,0]]
    assert_equal(MatrixDouble[[0,0,1],[0,0,1],[1,1,1]],
                 m1)
    m1.set_ones
    m1[1, 1] = MatrixDouble[[0,0],[0,0]]
    assert_equal(MatrixDouble[[1,1,1],[1,0,0],[1,0,0]],
                 m1)
  end

#   def test_ref
#     m1 = MatrixDouble.new(3,3)
#     m1.set_ones
#     assert_equal(MatrixDouble[[1,1,1],[1,1,1],[1,1,1]],
#                  m1)
#     m1_ref = m1.ref(0..1,0..1)
#     m1_ref.set_zero
#     assert_equal(MatrixDouble[[0,0,1],[0,0,1],[1,1,1]],
#                  m1)

#     m1 = MatrixDComplex.new(3,3)
#     m1.set_ones
#     m1_ref = m1.ref(0..1,0..1)
#     m1_ref.setConstant(1i)
#     assert_equal(MatrixDComplex[[1i,1i,1],[1i,1i,1],[1,1,1]],
#                  m1)   
#   end

#   def test_select
#     m0 = MatrixDouble.new(3,3)
#     m0.set_zero
#     m0[0,0] = 1
#     m2 = MatrixDouble.new(3,3)
#     m2.setConstant(2)
#     m = MatrixDouble.new(3,3)
#     m.set_ones
#     assert_equal( MatrixDouble[[2,0,0],[0,0,0],[0,0,0]],
#                   (m.cwiseEqual(m0)).select(m2, m0))
#     m1a = m.array
#     m0a = m0.array
#     tmp = (m0a >= m1a).select(m2, m0).matrix
#     assert_equal( MatrixDouble[[2,0,0],[0,0,0],[0,0,0]],
#                   tmp)
#   end

  def test_matrix_stack
    m1 = MatrixDouble.new(3,3)
    m1.set_ones
    m2 = MatrixDouble.new(3,3)
    m2.set_zero
    assert_equal(MatrixDouble.hstack(m1, m2),
                 MatrixDouble[ *Array.new(3){ [1, 1, 1, 0, 0, 0] } ])

    assert_equal(MatrixDouble.vstack(m1, m2),
                 MatrixDouble[ *(Array.new(3){ [1, 1, 1] } + Array.new(3){ [0, 0, 0] }) ])

    assert_equal(MatrixDouble.block_diagonal(1,2,3),
                 MatrixDouble[ [1,0,0], [0,2,0], [0,0,3] ])

    m3 = MatrixDouble.new(2,2)
    m3.set_ones
    assert_equal(MatrixDouble.block_diagonal(m3,2),
                 MatrixDouble[ [1,1,0], [1,1,0], [0,0,2] ])

    assert_raise(EigenRuntimeError){ MatrixDouble.block_diagonal(MatrixDouble.new(2,1),2) }

    assert_equal(MatrixDouble.block_diagonal([[1,1],[1,1]],1),
                 MatrixDouble[ [1,1,0], [1,1,0], [0,0,1] ])

    assert_equal(MatrixDComplex.block_diagonal([[1i,1],[1,1]],1+1i),
                 MatrixDComplex[ [1i,1,0], [1,1,0], [0,0,1+1i] ])

    assert_raise(EigenRuntimeError){ MatrixDouble.hstack(m1, m3) }
    assert_raise(EigenRuntimeError){ MatrixDouble.vstack(m1, m3) }
  end

  def test_solve
    m = MatrixDouble[ [1,0], [1, 2] ]
    solver = m.full_piv_lu()
    solver.solve(MatrixDouble[ [1], [1] ])
    solver.solve(VectorDFloat[1, 1])
  end

  def test_vector01
    assert_nothing_raised{ VectorDFloat[1, 2, 3] }
  end

  def test_spmatrix
    m = SpMatrixDouble.new(5,5)
    a = [[0,1,3], [1,0,22], [1,4,17], [2,0,7], [2,1,5], [2,3,1], [4,2,14], [4,4,8]]
    m.setFromTriplet(a)

    assert_equal(a.size, m.non_zeros)

    assert_equal([1, 2, 0, 2, 4, 2, 1, 4],
                 m.inner_indices)

    assert_equal([0,2,4,5,6,8], m.outer_indices)

    assert_raise(EigenRuntimeError){ m.reserve( [1,2] ) }

    assert_equal([22,7,3,5,14,1,17,8],
                 m.values)

    it = Eigen::SpMatrixDoubleIter.new(m, 0)
    assert_equal(22, it.value)
    assert_equal(7, it.next)
    assert_equal(7, it.value)
    assert_equal(2, it.index)
    assert (not it.end?)

    m = SpMatrixDouble.new(5,5)
    assert_nothing_raised{ m.reserve(7) }
  end

#  def test_float
#    MatrixFloat[[1,2],[3,4]]
#  end

end
