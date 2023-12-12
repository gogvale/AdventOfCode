# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true)
position = input.each_with_index.filter_map do
  [_2, _1.index('S')] if _1.scan(/S/).any?
end.first
previous_position = nil
steps = 0
$valid_directions = {
  N: %w[7 | F],
  E: %w[7 - J],
  S: %w[L | J],
  W: %w[F - L]
}
$wheel = {
  N: [-1, 0],
  E: [0, 1],
  S: [1, 0],
  W: [0, -1]
}

def opposite_direction(d)
  keys = $valid_directions.keys
  keys[(keys.index(d) + 2) % keys.size]
end

# queue = [[position, previous_position, steps]]
until input[position[0]][position[1]] == 'S' && previous_position
  wheel = $wheel.reject { _1 == previous_position }
                .transform_values{ [position[0] + _1,position[1] + _2] }
                .filter { $valid_directions[_1].include? input[_2[0]][_2[1]] }
  break if wheel.keys.empty?

  next_direction = wheel.keys.last
  previous_position, position = [opposite_direction(next_direction), wheel[next_direction]]
  steps += 1
end

puts steps / 2 + 1