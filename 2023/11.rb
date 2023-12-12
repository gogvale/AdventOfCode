# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true)
# Duplicate empty lines
rows = input.each_with_index.filter_map { _2 if /\A\.+\Z/.match? _1 }
cols = (0...input.first.length).filter { |i| input.all? { _1[i] == '.' } }

coords = input.each_with_index.map do |line, index|
  line.enum_for(:scan, /#/).map { [index, Regexp.last_match.begin(0)] }
end.flatten(1)

silver = coords.combination(2).map do |c1, c2|
  c1.zip(c2).each_with_index.sum do |values, index|
    a, b = values.sort
    b - a + ((a..b).to_a & [rows, cols][index]).count
  end
end.sum

gold = coords.combination(2).map do |c1, c2|
  c1.zip(c2).each_with_index.sum do |values, index|
    a, b = values.sort
    b - a + ((a..b).to_a & [rows, cols][index]).count * (1_000_000-1)
  end
end.sum

puts silver, gold