require 'pry'
input = File.open("input.txt").readlines.map(&:chomp)

i = input.map do |i|
    if i.empty?
        "$"
    else
        i
    end
end

any =  i.join("").split("$").map {|i| i.split("").uniq.join.length }.sum()
all =  i.join(" ").split("$").map{|i| i.strip.split.uniq}

all = all.map do |i|
    if i.length == 1
        i.first.length 
    else
        chars = i.join.split("").uniq
        chars.map{|char|  i.map {|i| i.include? char}.reduce(&:&) }.count(true)
    end
end
all = all.sum()

puts any
puts all