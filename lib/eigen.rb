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
