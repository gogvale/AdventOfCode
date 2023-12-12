# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true)

$rows = input.each_with_index.filter_map { _2 if /\A\.+\Z/.match? _1 }
$cols = (0...input.first.length).filter { |i| input.all? { _1[i] == '.' } }
coords = input.each_with_index.map do |line, index|
  line.enum_for(:scan, /#/).map { [index, Regexp.last_match.begin(0)] }
end.flatten(1)

def length_sum(coords, multiplier = 2)
  coords.combination(2).sum do |c1, c2|
    c1.zip(c2).each_with_index.sum do |values, index|
      a, b = values.sort
      b - a + ((a..b).to_a & [$rows, $cols][index]).count * (multiplier - 1)
    end
  end
end

silver = length_sum(coords)
gold = length_sum(coords, 1_000_000)

puts silver, gold