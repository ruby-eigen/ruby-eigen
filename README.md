# ruby-eigen
Ruby binding for Eigen, a C++ template library for linear algebra, implemented using SWIG.

Eigen Homepage: http://eigen.tuxfamily.org/

## How to install

### On Mac OS X

For Homebrew

    $ gem install rake-compiler
    $ gem install ruby-eigen

For MacPorts

    $ gem install rake-compiler
    $ gem install ruby-eigen

### On Ubuntu

    $ gem install rake-compiler
    $ gem install ruby-eigen

## License

ruby-eigen is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Because Eigen includes some routines licensed under the LGPL and we plan to enable these features,
we have chosen the LGPL.

This package includes the source of Eigen itself. See COPYING.* files in ext/eigen/eigen3/ for
the license of Eigen. See also http://eigen.tuxfamily.org/index.php?title=Main_Page#License

## Classes

    Eigen::MatrixDouble
    Eigen::MatrixDoubleRef
    Eigen::MatrixComplex
    Eigen::MatrixComplexRef
    Eigen::VectorDouble
    Eigen::VectorComplex
    Eigen::MatrixBool
    Eigen::VectorBool
    Eigen::EigenRuntimeError

MatrixDoubleRef instances, returned by MatrixDouble#ref,
share their memory with the original MatrixDouble instances.

```rb
require "eigen"
include Eigen
m = MatrixComplex.new(3,3)
m.setOnes
m_ref = m.ref(0..1,0..1)
m_ref.setConstant(1i)
p m == MatrixComplex[[1i,1i,1],[1i,1i,1],[1,1,1]] #=> true
```

## Class Methods

    MatrixDouble.new(rows, cols)
    MatrixDouble[*arrys]
    MatrixDouble.hstack(*matrices)
    MatrixDouble.vstack(*matrices)
    MatrixDouble.block_diagonal(*matrices)

## Instance Methods

    MatrixDouble#*
    MatrixDouble#+
    MatrixDouble#-
    MatrixDouble#-@
    MatrixDouble#/
    MatrixDouble#[i,j]
    MatrixDouble#[range0,range1]
    MatrixDouble#[]=(i, j, num)
    MatrixDouble#[]=(i, j, matrix)

    MatrixDouble#ref(range, range)

    MatrixDouble#to_a
    MatrixDouble#replicate

    MatrixDouble#adjoint
    MatrixDouble#conjugate
    MatrixDouble#transpose

    MatrixDouble#col(i)
    MatrixDouble#cols
    MatrixDouble#row(i)
    MatrixDouble#rows

    MatrixDouble#real

    MatrixDouble#cwiseAbs(other)
    MatrixDouble#cwiseAbs2(other)
    MatrixDouble#cwiseEqual(other)
    MatrixDouble#cwiseInverse
    MatrixDouble#cwiseMax(other)
    MatrixDouble#cwiseMin(other)
    MatrixDouble#cwiseNotEqual(other)
    MatrixDouble#cwiseProduct(other)
    MatrixDouble#cwiseQuotient(other)
    MatrixDouble#cwiseSqrt

    MatrixDouble#determinant
    MatrixDouble#diagonal

    MatrixDouble#getBottomLeftCorner(rows,cols)
    MatrixDouble#getBottomRightCorner(rows,cols)
    MatrixDouble#getTopLeftCorner(rows,cols)
    MatrixDouble#getTopRightCorner(rows,cols)
    MatrixDouble#setBottomLeftCorner(matrix)
    MatrixDouble#setBottomRightCorner(matrix)
    MatrixDouble#setTopLeftCorner(matrix)
    MatrixDouble#setTopRightCorner(matrix)

    MatrixDouble#middleCols
    MatrixDouble#middleRows

    MatrixDouble#setConstant(num)
    MatrixDouble#setIdentity
    MatrixDouble#setOnes
    MatrixDouble#setRandom
    MatrixDouble#setZero

    MatrixDouble#hasNaN
    MatrixDouble#inverse
    MatrixDouble#isApprox
    MatrixDouble#isApproxToConstant
    MatrixDouble#isConstant
    MatrixDouble#isDiagonal
    MatrixDouble#isIdentity
    MatrixDouble#isLowerTriangular
    MatrixDouble#isMuchSmallerThan
    MatrixDouble#isOnes
    MatrixDouble#isUpperTriangular
    MatrixDouble#isZero

    MatrixDouble#maxCoeff
    MatrixDouble#minCoeff

    MatrixDouble#norm
    MatrixDouble#normalize
    MatrixDouble#operatorNorm

    MatrixDouble#prod

    MatrixDouble#reverse

    MatrixDouble#sum

    MatrixDouble#tril
    MatrixDouble#triu

    MatrixDouble#eigenvalues
    MatrixDouble#fullPivHouseholderQR
    MatrixDouble#fullPivLu

    MatrixDouble#ldlt
    MatrixDouble#llt
    MatrixDouble#lu

    MatrixDouble#svd

