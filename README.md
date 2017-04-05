# ruby-eigen
Ruby binding for Eigen, a C++ template library for linear algebra, implemented using SWIG.

Eigen Homepage: http://eigen.tuxfamily.org/

## How to install

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

    Eigen::DFloatMatrix
    Eigen::SFloatMatrix
    Eigen::DComplexMatrix
    Eigen::SComplexMatrix
    Eigen::Int64Matrix
    Eigen::Int32Matrix
    Eigen::Int16Matrix
    Eigen::Int8Matrix
    Eigen::UInt64Matrix
    Eigen::UInt32Matrix
    Eigen::UInt16Matrix
    Eigen::UInt8Matrix

    Eigen::DFloatVector
    Eigen::SFloatVector
    Eigen::DComplexVector
    Eigen::SComplexVector
    Eigen::Int64Vector
    Eigen::Int32Vector
    Eigen::Int16Vector
    Eigen::Int8Vector
    Eigen::UInt64Vector
    Eigen::UInt32Vector
    Eigen::UInt16Vector
    Eigen::UInt8Vector



