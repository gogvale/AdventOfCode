require 'pry'
input = File.open("input.txt").readlines.map(&:chomp)

i = input.map do |i|
    if i.empty?
        "$"
    else
        i
    end
end

any =  i.join("")
        .split("$")
        .map {|i| i.split("").uniq.join.length }
        .sum()

all =  i.join(" ")
        .split("$")
        .map{|i| i.strip.split.uniq}
        .map{ |i| i.join.split("").uniq
        .map{|char|  i.map {|i| i.include? char}.reduce(&:&) }
        .count(true) }
        .sum()

puts any
puts all