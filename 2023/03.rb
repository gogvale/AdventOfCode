# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true)

numbers = input.each_with_index.map do |line, index|
  line.to_enum(:scan, /\d+/).map do |m,|
    inner_index = $`.size
    { value: m, coordinates: (0...m.size).map { |i| [index, i + inner_index] } }
  end
end.flatten

$max_height = input.size
$max_width = input.first.size

def get_box(coord)
  box = []
  (coord[0] - 1..coord[0] + 1).each do |y|
    (coord[1] - 1..coord[1] + 1).each do |x|
      new_coord = [y, x]
      box << new_coord
    end
  end
  box.reject do |new_coord|
    new_coord[0] < 0 || new_coord[0] > $max_height ||
      new_coord[1] < 0 || new_coord[1] > $max_width ||
      new_coord == coord
  end
end

silver_symbols = []
gold_symbols = []

input.each_with_index.map do |line, index|
  line.to_enum(:scan, /[^.\d]/).map do |m,|
    inner_index = $`.size
    coords = get_box([index, inner_index])
    silver_symbols += coords if coords.any? { input[_1][_2].match?(/\d/) }
    if m == '*'
      coords = coords.select { input[_1][_2].match?(/\d/) }
      m_numbers = numbers.filter_map do |number|
        number[:value].to_i if (number[:coordinates] & coords).any?
      end
      gold_symbols << m_numbers.reduce(:*)  if m_numbers.size == 2
    end
  end
end

silver = numbers.filter_map do |el|
  el[:value].to_i if el[:coordinates].any? { silver_symbols.include? _1 }
end.sum
gold = gold_symbols.sum

puts silver, gold
