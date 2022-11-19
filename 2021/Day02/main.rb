# frozen_string_literal: true

@values = File.open("#{File.dirname(__FILE__)}/input.txt", 'r').to_a.map { _1.chomp }
movement = @values.map do
  direction, magnitude = _1.split
  magnitude.to_i * { forward: 1, down: 1i, up: -1i }[direction.to_sym]
end.sum
puts movement.real * movement.imaginary

position = 0
depth = 0
aim = 0
@values.each do |instruction|
  order, magnitude = instruction.split
  magnitude = magnitude.to_i
  case order
  when 'forward'
    position += magnitude
    depth += magnitude * aim
  when 'up'
    aim -= magnitude
  else
    aim += magnitude
  end
end
puts position * depth
