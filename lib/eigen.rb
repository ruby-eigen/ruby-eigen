require 'eigen/eigen'

class Eigen::MatrixDouble
  def self.[](*rows)    
    ret = new(rows.size, rows[0].size)
    rows.each_with_index{|rw, i|
      ret.__set_row__(i, rw)
    }
    ret 
  end
end
