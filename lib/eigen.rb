require 'eigen/eigen'


module Eigen::MatrixConstructor
  def [](*rows)
    ret = new(rows.size, rows[0].size)
    rows.each_with_index{|rw, i|
      ret.__set_row__(i, rw)
    }
    return ret
  end

  def hstack(*ms)
    col_size = ms.inject(0){|sum, m| m.cols + sum }
    row_size = ms[0].rows
    ret = new(row_size, col_size)
    col_ind = 0
    ms.each{|m|
      ret.__set_block__(0,col_ind,m)
      col_ind += m.cols
    }
    return ret
  end

  def vstack(*ms)
    row_size = ms.inject(0){|sum, m| m.rows + sum }
    col_size = ms[0].cols
    ret = new(row_size, col_size)
    row_ind = 0
    ms.each{|m|
      ret.__set_block__(row_ind,0,m)
      row_ind += m.rows
    }
    return ret
  end

  def block_diagonal(*ms)
    row_size = ms.inject(0){|sum, m|
     if m.respond_to?(:rows)
       raise(Eigen::EigenRuntimeError, "rows and cols are not equal") unless m.rows == m.cols
       sum + m.rows
     elsif m.is_a?(Numeric)
       sum + 1
     elsif m.is_a?(Array)
       sum + m.size
     else
       raise Eigen::EigenRuntimeError
     end
    }
    col_size = row_size
    ret = new(row_size, row_size)
    ret.setZero
    row_ind = 0
    ms.each{|m|
      if m.respond_to?(:rows)
        ret.__set_block__(row_ind, row_ind, m)
        row_ind += m.rows
      elsif m.is_a?(Array)
        m0 = self[*m]
        raise(Eigen::EigenRuntimeError, "rows and cols are not equal") unless m0.rows == m0.cols
        ret.__set_block__(row_ind, row_ind, m0)
        row_ind += m.size
      else
        ret[row_ind, row_ind] = m
        row_ind += 1
      end
    }
    return ret
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
