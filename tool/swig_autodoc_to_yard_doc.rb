def klass_name(s)
  if /(.*)\:\:(.*)\.\S+/ =~ s
    $2
  end
end

def arg_names(s)
  return [] unless s
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

def arg_types(s)
  return [] unless s
  s = s[1..-2]
  s.split(",").map{|arg| arg.sub(/\A +/,"").sub(/ \S+\z/, "") }
end


def arg_name_str(arg_names)
  if arg_names.size > 0
    "(" + arg_names.join(",") + ")"
  else
    ""
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
    h[klass][method] << [arg, returned_klass]
  end
}

h = h.delete_if{|k, v| /DFloat/ !~ k}
h.each{|klass, h|
  h.each{|method, arry|

    if arry.size > 1
      puts
      puts arry[0]
      arry.each{|arg, returned_klass|
        arg_name_a = arg_names(arg)
        a = arg_name_str(arg_name_a)
        type_names = arg_types(arg)
        puts "  # @overload #{method}#{a}"
        arg_name_a.each_with_index{|s, i|
          puts "  #   @param #{s} [#{type_names[i]}]"
        }
          puts "  #   @return [#{returned_klass}]"
      }
      puts "  def #{method}(*args)"
      puts "  end"
    else
      arg_name_a = arg_names(arry[0][0])
      a = arg_name_str(arg_name_a)
      type_names = arg_types(arry[0][0])
      returned_klass = arry[0][1]
      puts 
      arg_name_a.each_with_index{|s, i|
         puts "  # @param #{s} [#{type_names[i]}]"
      }
      puts "  # @return [#{returned_klass}]"
      puts "  def #{method}#{a}"
      puts "  end"
    end
  }
}
#     arg_names = arg_names(prev_arg)
#     type_names = arg_types(prev_arg)
#     if arg_names.size > 0
#       a = "(" + arg_names.join(",") + ")"
#     end

#     if overload or (method == prev_method)
#       overload = true
#       puts "  # @overload #{method}#{a}"
#     elsif prev_method
#       overload = false
#       puts
#       puts prev_arg
#       arg_names.each_with_index{|s, i|
#         puts "  # @param #{s} [#{type_names[i]}]"
#       }
#       puts "  # @return [#{prev_returned_klass}]"
#       puts "  def #{prev_method}#{a}"
#       puts "  end"
#     end

#     prev_klass = klass
#     prev_method = method
#     prev_arg = arg
#     prev_returned_klass = returned_klass
#   end

# }

puts "end"
