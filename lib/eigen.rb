require 'eigen/eigen'


module Eigen::MatrixConstructor
  def [](*rows)
    ret = new(rows.size, rows[0].size)
    rows.each_with_index{|rw, i|
      ret.__set_row__(i, rw)
    }
    ret
  end
end

module Eigen::MatrixCommon
  def to_a
    ret = Array.new(rows())
    (0..(rows()-1)).each{|i|
      ret[i] = __get_row_array__(i)
    }
    ret
  end
end

class Eigen::MatrixDouble
  extend  Eigen::MatrixConstructor
  include Eigen::MatrixCommon
end

class Eigen::MatrixComplex
  extend  Eigen::MatrixConstructor
  include Eigen::MatrixCommon
end

module Eigen::VectorConstructor
  def [](*args)
    ret = new(args.size)
    ret.__set_segment__(0, args.size, args)
    ret
  end
end

module Eigen::VectorCommon
end

class Eigen::VectorDouble
  extend  Eigen::VectorConstructor
  include Eigen::VectorCommon
end

class Eigen::VectorComplex
  extend  Eigen::VectorConstructor
  include Eigen::VectorCommon
end
