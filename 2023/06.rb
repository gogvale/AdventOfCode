# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true)

def calculate_victories(time, distance)
  sol1 = (time - (time ** 2 - 4 * distance) ** 0.5) / -2
  sol2 = (time + (time ** 2 - 4 * distance) ** 0.5) / -2
  (sol2.floor - sol1.ceil + 1).abs
end

silver = input.map { _1.scan(/\d+/).map(&:to_i) }.reduce(&:zip).map do
  calculate_victories(_1, _2)
end.reduce(:*)

gold = calculate_victories(*input.map { _1.scan(/\d/).join.to_i })

puts silver, gold