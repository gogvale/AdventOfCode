sum = 2020
file = File.open("files/input_day01.txt")
input = file.readlines.map{|line| line.chomp.to_i}


input.each_with_index do |value,idx|
    input[idx..-1].each{|i| puts "#{value} × #{i} = #{value*i}" if value + i == sum}
end