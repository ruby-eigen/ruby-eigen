class Arg

  def initialize(method, arg, returned_klass)
    @method = method
    @returned_klass = convert_type_name(returned_klass)
    @args = arg
  end
  attr :method, :args, :returned_klass

  def arg_names_a
    return [] unless @args
    s = @args
    s = s[1..-2]
    ret = s.split(",").map{|arg| arg.sub(/\A.* /, "") }
    ret.map{|s|
      if /arg(\d+)/ =~ s
        "arg" + ($1.to_i - 1).to_s
      else
        s
      end
    }
  end

  def arg_names_s
    a = arg_names_a
    if a.size > 0
      "(" + a.join(",") + ")"
    else
      ""
    end
  end

  def type_names_a
    return [] unless @args
    s = @args
    s = s[1..-2]
    s.split(",").map{|arg| 
      convert_type_name( arg.sub(/\A +/,"").sub(/ \S+\z/, "") )
    }
  end

  def convert_type_name(type)
    case type
    when "double"
      "Float"
    when "int", "size_t"
      "Integer"
    when "std::string"
      "String"
    when /\Astd\:\:vector< *(\S+) *,/
      type = convert_type_name($1)
      "Array<#{type}>"
    else
      type
    end
  end

  def def_method
    ret = ""
    type_names = type_names_a
    a = arg_names_a
      a.each_with_index{|s, i|
         ret << "  # @param #{s} [#{type_names[i]}]\n"
      }
      ret << "  # @return [#{@returned_klass}]\n"
      ret << "  def #{@method}#{arg_names_s}\n"
      ret << "  end\n"
  end

  def overload_method
    ret = ""
    ret << "  # @overload #{@method}#{arg_names_s}\n"
    type_names = type_names_a
    arg_names_a.each_with_index{|s, i|
      ret << "  #   @param #{s} [#{type_names[i]}]\n"
    }
    ret << "  #   @return [#{@returned_klass}]\n"
  end

end

def klass_name(s)
  if /(.*)\:\:(.*)\.\S+/ =~ s
    $2
  end
end

klass = nil
h = {}
ARGF.each_line{|l|
  if /\A  Document-method: (.*)/ =~ l
    klass = klass_name($1)
    h[klass] ||= {}
  elsif /\A    (\S+)(\(.*?\))? -> (.*)/ =~ l
    method = $1
    arg = $2
    returned_klass = $3
    h[klass][method] ||= []
    h[klass][method] << Arg.new(method, arg, returned_klass)
  end
}

h = h.delete_if{|k, v| /DFloat/ !~ k}
puts "module Eigen"
h.each{|klass, h|
  puts
  puts "class #{klass}"
  h.each{|method, arry|
    if arry.size > 1
      puts
      arry.each{|arg|
        puts arg.overload_method
      }
      puts "  def #{method}(*args)"
      puts "  end"
    else
      arg = arry[0]
      puts 
      puts arg.def_method
    end
  }
  puts "end"
}
puts "end"

