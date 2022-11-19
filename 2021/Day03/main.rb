# frozen_string_literal: true

@values = File.open("#{File.dirname(__FILE__)}/input.txt", 'r').to_a.map { _1.chomp }
gamma = @values.map(&:chars).transpose.map { _1.count('0') > _1.size / 2 ? '0' : '1' }.join
epsilon = gamma.gsub(/./, '0' => '1', '1' => '0')
puts gamma.to_i(2) * epsilon.to_i(2)

def get_value(input, operator)
  (0..input.first.length).each do |index|
    most_common_bit = input.map { _1[index] }.count('0').send(operator.to_sym, input.size / 2) ? '0' : '1'
    input = input.select { _1[index] == most_common_bit }
    break if input.size == 1
  end

  input.first
end

oxygen = get_value(@values, :>)
carbon = get_value(@values, :<=)
puts oxygen.to_i(2) * carbon.to_i(2)
