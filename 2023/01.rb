# frozen_string_literal: true

input = IO.read('input.txt').split
part1 = input.sum do |line|
  numbers = line.scan(/\d/)
  "#{numbers.first}#{numbers.last}".to_i
end
part2 = input.sum do |line|
  words = %w[one two three four five six seven eight nine]
  word_numbers = (1..9).to_a.map(&:to_s)
  numbers = line.scan(/(?=(#{Regexp.union(words + word_numbers)}))/).flatten.map { words.find_index(_1)&.send(:+, 1) or _1 }
  "#{numbers.first}#{numbers.last}".to_i
end

puts part1
puts part2
