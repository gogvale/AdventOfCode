@values = File.open("#{File.dirname(__FILE__)}/input.txt", 'r').to_a.map { _1.chomp.to_i }

def changed(values)
  values.select.with_index { |i, idx| i > values[idx - 1] }.size
end
puts changed(@values)

@values = (0...@values.length - 2).map.with_index { |_i, idx| @values[idx..idx + 2].sum }
puts changed(@values)
