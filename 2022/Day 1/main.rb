@values = File.open("#{File.dirname(__FILE__)}/input.txt").to_a.join.split(/\n\n/).map { _1.split.map(&:to_i) }
puts @values.map(&:sum).max
puts @values.map(&:sum).sort.last(3).sum
