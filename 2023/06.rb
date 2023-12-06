# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true)

def calculate_victories(time, distance)
  (0..time).count { _1 * (time - _1) > distance }
end

silver = input.map { _1.scan(/\d+/).map(&:to_i) }.reduce(&:zip).map do
  calculate_victories(_1, _2)
end.reduce(:*)

gold = calculate_victories(*input.map { _1.scan(/\d/).join.to_i })

puts silver, gold