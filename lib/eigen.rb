require 'eigen/eigen'


module Eigen
  module MatrixConstructor
    def [](*rows)
      ret = new(rows.size, rows[0].size)
      rows.each_with_index{|rw, i|
        ret.__set_row__(i, rw)
      }
      ret
    end
  end
end

class Eigen::MatrixDouble
  extend Eigen::MatrixConstructor
end

class Eigen::MatrixComplex
  extend Eigen::MatrixConstructor
end

module Eigen
  module VectorConstructor
    def [](*args)
      ret = new(args.size)
      ret.__set_segment__(0, args.size, args)
      ret
    end
  end
end

class Eigen::VectorDouble
  extend Eigen::VectorConstructor
end

class Eigen::VectorComplex
  extend Eigen::VectorConstructor
end
