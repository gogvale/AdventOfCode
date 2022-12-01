# frozen_string_literal: true

@values = File.open("#{File.dirname(__FILE__)}/input.txt", 'r').first.split(',').map(&:to_i)
80.times do
  @values.count(0).times { @values << 9 }
  @values.map! { _1.zero? ? 6 : _1 - 1 }
end
puts @values.size

fishes = File.open("#{File.dirname(__FILE__)}/input.txt", 'r').first.split(',').map(&:to_i).sort.tally
fishes.default = 0

256.times do
  fishes.transform_keys! { _1 - 1 }
  fishes[6] += fishes[-1]
  fishes.transform_keys!(-1 => 8)
end

puts fishes.values.sum
