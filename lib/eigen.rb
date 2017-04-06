require 'numo/narray'
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
      raise Eigen::EigenRuntimeError, "row sizes are different" unless row_size == m.rows
      ret[0,col_ind] = m
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
      raise Eigen::EigenRuntimeError, "col sizes are different" unless col_size == m.cols
      ret[row_ind,0] = m
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
    ret.set_zero
    row_ind = 0
    ms.each{|m|
      if m.respond_to?(:rows)
        ret[row_ind, row_ind] = m
        row_ind += m.rows
      elsif m.is_a?(Array)
        m0 = self[*m]
        raise(Eigen::EigenRuntimeError, "rows and cols are not equal") unless m0.rows == m0.cols
        ret[row_ind, row_ind] = m0
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

  def row_range(r)
    if r.is_a?(Numeric)
      i0 = r
      row_size = 1
    else
      i0 = r.begin >= 0 ? r.begin : r.begin + rows()
      row_size = r.end >= 0 ? r.size : r.end + rows() + 1
    end
    return [i0, row_size]
  end

  def col_range(r)
    if r.is_a?(Numeric)
      j0 = r
      col_size = 1
    else
      j0 = r.begin >= 0 ? r.begin : r.begin + cols()
      col_size = r.end >= 0 ? r.size : r.end + cols() + 1
    end
    return [j0, col_size]
  end
  private "row_range", "col_range"

  def [](i,j)
    return __get_item__(i,j) if i.is_a?(Numeric) and j.is_a?(Numeric)

    if i == true
      i0, row_size = 0, rows()
    else
      i0, row_size = row_range(i)
    end
    if j == true
      j0, col_size = 0, cols()
    else
      j0, col_size = col_range(j)
    end

    return __get_block__(i0, j0, row_size, col_size)
  end

  def ref(range0, range1)
    if range0 == true
      i0, row_size = 0, rows()
    else
      i0, row_size = row_range(range0)
    end
    if range1 == true
      j0, col_size = 0, cols()
    else
      j0, col_size = col_range(range1)
    end

    return __ref__(i0, j0, row_size, col_size)
  end

  def to_a
    ret = Array.new(rows())
    (0..(rows()-1)).each{|i|
      ret[i] = __get_row_array__(i)
    }
    ret
  end
end

class Eigen::DFloatMatrix
  extend  Eigen::MatrixConstructor
  include Eigen::MatrixCommon
  private "__get_item__", "__get_block__"
end

class Eigen::SFloatMatrix
  extend  Eigen::MatrixConstructor
  include Eigen::MatrixCommon
  private "__get_item__", "__get_block__"
end

class Eigen::DComplexMatrix
  extend  Eigen::MatrixConstructor
  include Eigen::MatrixCommon
  private "__get_item__", "__get_block__"
end

class Eigen::SComplexMatrix
  extend  Eigen::MatrixConstructor
  include Eigen::MatrixCommon
  private "__get_item__", "__get_block__"
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

class Eigen::DFloatVector
  extend  Eigen::VectorConstructor
  include Eigen::VectorCommon
end

class Eigen::DComplexVector
  extend  Eigen::VectorConstructor
  include Eigen::VectorCommon
end

module Eigen::SpMatrixCommon

  def set_from_triplet(arry)
    arry0 = arry.sort{|a, b|
      ret = a[1] <=> b[1]
      ret == 0 ? a[0] <=> b[0] : ret
    }
    each_col_size = Array.new(cols(), 0)
    arry0.slice_when{|a, b| a[1] != b[1] }.each{|e|
      each_col_size[ e[0][1] ] = e.size
    }
    reserve( each_col_size )
    arry0.each{|e|
      __insert__(e[0], e[1], e[2])
    }
  end

  def reserve( arg )
    if arg.respond_to?(:to_int)
      return __reserve__( arg )
    end
    raise Eigen::EigenRuntimeError unless arg.size == cols()
    __reserve__( arg )
  end

end


class Eigen::DFloatSpMatrix
  include Eigen::SpMatrixCommon
  private "__reserve__", "__insert__"
end
