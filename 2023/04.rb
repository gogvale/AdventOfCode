# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true).map do |line|
  line.split(': ').last.split(' | ').map { _1.scan(/\d+/).map(&:to_i) }
end
silver = input.sum { (2 ** ((_1 & _2).size - 1)).to_i }
scratchcards = (1..input.size).map { [_1, 1] }.to_h
input.each_with_index do |line, i|
  mine, winning = line
  matching = (mine & winning).size
  (i + 2..matching + i + 1).each {|j| scratchcards[j] += scratchcards[i+1] if scratchcards.keys.include? j }
  scratchcards
end
gold = scratchcards.values.sum
puts silver, gold