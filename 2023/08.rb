# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true)

$directions = input[0]
$input = input[2..].map do
  k, v1, v2 = _1.scan(/\w{3}/)
  [k, [v1, v2]]
end.to_h

def calculate_steps(position, end_position = /ZZZ/)
  step = 0
  until end_position.match?(position)
    direction = %w[L R].index($directions[step % $directions.length])
    position = $input[position][direction]
    step += 1
  end
  step
end

silver = calculate_steps('AAA')
gold = $input.keys.filter { _1.match? /A\Z/ }
             .map { calculate_steps(_1, /Z\Z/) }
             .reduce(1) { |acc, n| acc.lcm(n) }

puts silver, gold
