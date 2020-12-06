input = File.open("input.txt").readlines.map(&:chomp)

i = input.map { |i| i.empty? ? "$" : i }

any =  i.join("").split("$")
        .map {|i| i.split("").uniq.join.length }
        .sum()

all =  i.join(" ").split("$")
        .map{|i| i.strip.split.uniq}
        .map{ |i| i.join.split("").uniq
        .map{|char| i.map {|i| i.include? char}.reduce(&:&) }.count(true) }
        .sum()

puts any # 6947
puts all # 3398