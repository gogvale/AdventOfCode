# frozen_string_literal: true

file = File.read("#{File.dirname(__FILE__)}/input.txt")
values, instructions = file.split("\n\n").map { _1.split("\n") }
silver = values.each_with_object([]) do |value, arr|
  arr << value.chars.each_slice(4).map { _1.join.scan(/\[(.)\]/).first }.reverse
end.transpose.map { _1.reverse.compact }.reverse
gold = silver.map(&:dup)
instructions.each do |instruction|
  number, from, to = instruction.scan(/(\d+)/).map(&:first).map(&:to_i)
  number.times { silver[to - 1] << silver[from - 1].pop }
  gold[to - 1] += gold[from - 1].pop(number)
end

puts silver.map(&:last).join
puts gold.map(&:last).join
