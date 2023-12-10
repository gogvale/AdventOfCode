# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true)
          .map { _1.split.map(&:to_i) }

def last_digit(arr)
  return 0 if arr.all?(&:zero?)

  last_digit(arr.each_cons(2).map { _2 - _1 }) + arr.last
end

silver = input.sum { last_digit(_1) }
gold = input.map(&:reverse).sum { last_digit(_1) }

puts silver, gold