def get_invalid(index: 25)
  until index == @values.size
    invalid = @values[index]
    return invalid unless @values[index - 25..index].permutation(2).map(&:sum).include?(invalid)

    index += 1
  end
end

def get_sum(invalid:)
  (0..@values.length).each do |i|
    (1..@values.length).each do |j|
      next unless j - i > 1

      inner_values = @values[i..j]
      return inner_values.min + inner_values.max if inner_values.sum == invalid
    end
  end
end

@values = File.open('input.txt', 'r').to_a.map { _1.chomp.to_i }
invalid = get_invalid
sum = get_sum(invalid: invalid)
puts invalid
puts sum
