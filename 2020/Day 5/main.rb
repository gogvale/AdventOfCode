require "pry"
input = File.open("input.txt").readlines.map(&:chomp)

def get_row(str)
    ceil = 127
    floor = 0
    str = str.split ""
    str.each do |char|
        ceil = (ceil+floor)/2 if char == 'F'
        floor = (ceil+floor)/2 if char == 'B'
    end
    str[-1] == 'F' ? ceil : floor
end


def get_col(str)
    str.gsub("R","1").gsub("L","0").to_i(2)
end



def get_ID(str)
    row_str = str[0..-4]
    col_str = str[-3..]
    return get_col(col_str) + 8*get_row(row_str) 
end

# binding.pry

puts input.map{ |i| get_ID(i)}.max