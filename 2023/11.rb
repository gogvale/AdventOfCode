# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true)
# Duplicate empty lines
input.each_with_index.filter_map { _2 if /\A\.+\Z/.match? _1 }.each_with_index do |i, j|
  input.insert(i + j, input[i + j])
end
(0...input.first.length).filter { |i| input.all? { _1[i] == '.' } }.each_with_index do |i, j|
  input.map { _1.insert(i + j, '.') }
end
coords = input.each_with_index.map do |line, index|
  line.enum_for(:scan, /#/).map { [index, Regexp.last_match.begin(0)] }
end.flatten(1)
silver = coords.combination(2).map do |c1, c2|
  c1.zip(c2).sum { (_2 - _1).abs }
end.sum

puts silver