sum = 2020
file = File.open("../files/input_day01.txt")
input = file.readlines.map{|line| line.chomp.to_i}


# Challenge 1
input.each_with_index do |value,idx|
    input[idx..-1].each{|i| puts value*i if value + i == sum}
end

# Challenge 2
input.each_with_index do |value,idx|
    input[idx..-1].each_with_index do |value_2, idx_2|
        input[idx_2..-1].each do |value_3| 
            if value + value_2 + value_3 == sum
                puts value*value_2*value_3
                return
            end
        end
    end
end
