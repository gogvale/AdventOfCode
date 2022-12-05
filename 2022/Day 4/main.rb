# frozen_string_literal: true

@values = File.open("#{File.dirname(__FILE__)}/input.txt", 'r').to_a.map do |str|
  str.split(',').map { Range.new(*_1.split('-').map(&:to_i)).to_a }
end

puts @values.count { |a, b| [a, b].any? { _1 == a & b } }
puts @values.count { (_1 & _2).any? }
