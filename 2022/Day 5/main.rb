# frozen_string_literal: true

values, instructions = File.open("#{File.dirname(__FILE__)}/input.txt").read.split("\n\n").map{_1.split("\n")}
silver = values.each_with_object([]) do |value, arr|
  arr << value.chars.each_slice(4).to_a.map(&:join).map do
    _1.scan(/\[(.)\]/).first&.first
  end.reverse
end.transpose.map(&:reverse).map(&:compact).reverse
gold = silver.map(&:dup)

instructions.each do |instruction|
  number, from, to = instruction.scan(/(\d+)/).map(&:first).map(&:to_i)
  number.times { silver[to - 1] << silver[from - 1].pop }
  gold[to - 1] += gold[from - 1].pop(number)
end

puts silver.map { _1.last }.join
puts gold.map { _1.last }.join
