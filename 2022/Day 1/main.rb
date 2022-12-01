@values = []
index = 0
File.open("#{File.dirname(__FILE__)}/input.txt", 'r').each do |i|
  if i.chomp == ''
    index += 1
  else
    @values[index] ||= []
    @values[index] << i.to_i
  end
end

puts @values.map(&:sum).max
puts @values.map(&:sum).sort.last(3).sum