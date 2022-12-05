# frozen_string_literal: true

file = File.open("#{File.dirname(__FILE__)}/input.txt").readlines
index = file.index { _1.match? /^\n$/ }
instructions = file[index + 1..]
@values = file[0...index]

crates = @values.each_with_object([]) do |value, arr|
  arr << value.chars.each_slice(4).to_a.map(&:join).map do
    _1.scan(/\[(.)\]/).first&.first
  end.reverse
end.transpose.map(&:reverse).map(&:compact).reverse

def parse_instruction(instruction)
  instruction.scan(/(\d+)/).map(&:first).map(&:to_i)
end

silver = instructions.each_with_object(crates.map(&:dup)) do |instruction, crates|
  number, from, to = parse_instruction(instruction)
  number.times { crates[to - 1] << crates[from - 1].pop }
end.map { _1.last }.join

gold = instructions.each_with_object(crates.map(&:dup)) do |instruction, crates|
  number, from, to = parse_instruction(instruction)
  crates[to - 1] += crates[from - 1].pop(number)
end.map { _1.last }.join

puts silver
puts gold
