module SwigCxxToYard
class Arg

  def initialize(klass, method, arg, returned_klass)
    @klass = klass
    @method = method
    @returned_klass = convert_type_name(returned_klass)
    @args = arg
  end
  attr_accessor :klass, :method, :args, :returned_klass, :is_klass_method

  def arg_names_array
    return [] unless @args
    s = @args
    s = s[1..-2]
    s = s.gsub(/,std\:\:allocator<.*?>/, "")
    ret = s.split(",").map{|arg| arg.sub(/\A.* /, "") }
    ret.map{|s|
      if /arg(\d+)/ =~ s
        "arg" + ($1.to_i - 1).to_s
      else
        s
      end
    }
  end

  def arg_names_str
    a = arg_names_array
    if a.size > 0
      "(" + a.join(",") + ")"
    else
      ""
    end
  end

  def type_names_array
    return [] unless @args
    s = @args
    s = s[1..-2]
    s = s.gsub(/,std\:\:allocator<.*?>/, "")
    s.split(",").map{|arg| 
      convert_type_name( arg.sub(/\A +/,"").sub(/ \S+\z/, "") )
    }
  end

  def convert_type_name(type)
    case type
    when nil
      "nil"
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
    type_names = type_names_array
    a = arg_names_array()
      a.each_with_index{|s, i|
         ret << "  # @param #{s} [#{type_names[i]}]\n"
      }
    ret << "  # @return [#{@returned_klass}]\n"
    if @is_klass_method
      ret << "  def #{@klass}::#{@method}#{arg_names_str}\n"
    else
      ret << "  def #{@method}#{arg_names_str}\n"
    end
    ret << "  end\n"
  end

  def overload_method
    ret = ""
    ret << "  # @overload #{@method}#{arg_names_str}\n"
    type_names = type_names_array
    arg_names_array().each_with_index{|s, i|
      ret << "  #   @param #{s} [#{type_names[i]}]\n"
    }
    ret << "  #   @return [#{@returned_klass}]\n"
  end

end

class Method

  def initialize(klass, methd, is_klass_method = false)
    @klass = klass
    @name = methd
    @args   = []
    @is_klass_method = is_klass_method
  end
  attr_accessor :klass, :name, :args, :is_klass_method

  def push_arg(a)
    @args << a
  end

  def to_s
    ret = "\n"
    if @args.size > 1
      @args.each{|arg|
        ret << arg.overload_method
      }
      ret << "  def #{@name}(*args)" << "\n"
      ret << "  end" << "\n"
    else
      @args[0].def_method
    end
  end

end

class Klass

  def initialize(klass)
    @name = klass
    @klass_methods = {}
    @instc_methods = {}
  end
  attr_accessor :name, :klass_methods, :instc_methods

  def push_klass_method_arg(a)
    @klass_methods[a.method].push_arg(a)
  end

  def push_instc_method_arg(a)
    @instc_methods[a.method].push_arg(a)
  end

end

end # module SwigCxxToYard

def klass_name(s)
  if /(.*)\:\:(.*)\.\S+/ =~ s
    $2
  else
    s
  end
end

klass = nil
h = {}
current_arg = nil
file_s = ARGF.read
docs = file_s.scan(/\/\*.*?\*\//m).find_all{|s| /^  Document-method: (.*)/ =~ s }

docs.each{|s|

  if /^  Document-method: (.*)/ =~ s
    klass = klass_name($1)
    h[klass] ||= SwigCxxToYard::Klass.new(klass)
  else
    raise s
  end

  case s
  when /^\s+\S+\.new(\(.*?\))?/
    method = "new"
    arg = $1
    returned_klass = klass
    h[klass].klass_methods[method] ||= SwigCxxToYard::Method.new(klass, method, true)
    h[klass].push_klass_method_arg( SwigCxxToYard::Arg.new(klass, method, arg, returned_klass) )
  when /^  call-seq:\n    (\S+)(\(.*?\))? -> (.*?)\n/m, /^  call-seq:\n    (\S+)(\(.*?\))?\n/m
    method = $1
    arg = $2
    returned_klass = $3
    if /^A class method./ =~ s
      h[klass].klass_methods[method] ||= SwigCxxToYard::Method.new(klass, method)
      h[klass].push_klass_method_arg( SwigCxxToYard::Arg.new(klass, method, arg, returned_klass) )
    else
      h[klass].instc_methods[method] ||= SwigCxxToYard::Method.new(klass, method)
      h[klass].push_instc_method_arg(SwigCxxToYard::Arg.new(klass, method, arg, returned_klass))
    end
  else
    raise s
  end

}

h = h.delete_if{|k, v| /DFloat/ !~ k}
puts "module Eigen"
h.each{|name, klass|
  puts
  puts "class #{klass.name}"
  puts

  klass.instc_methods.each{|name, methd|
    puts methd.to_s
    puts
  }

  klass.klass_methods.each{|name, methd|
    puts methd.to_s
    puts
  }

  puts "end"
  puts
}
puts "end"

