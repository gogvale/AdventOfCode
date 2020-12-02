sum = 2020
file = File.open("../files/input_day01.txt")
input = file.readlines.map{|line| line.chomp.to_i}


def challenge_1(input,sum)
    input.each_with_index do |value,idx|
        input[idx..].each do |value2| 
            return value * value2 if value + value2 == sum
        end
    end
end

def challenge_2(input,sum)
    input.each_with_index do |value,idx|
        input[idx..].each_with_index do |value2, idx2|
            input[idx2..].each do |value3| 
                return value * value2 * value3 if value + value2 + value3 == sum
            end
        end
    end
end

puts challenge_1(input,sum)
puts challenge_2(input,sum)