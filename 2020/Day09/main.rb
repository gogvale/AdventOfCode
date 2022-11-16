values = File.open('input.txt', 'r').to_a.map { _1.chomp.to_i }
@index = 25

until @index == values.size
  preamble = values[@index - 25..@index]
  value = values[@index]
  @invalid = value
  unless preamble.permutation(2).map(&:sum).include?(value)
    puts @invalid
    break
  end

  @index += 1
end

(0..values.length).each do |i|
  (1..values.length).each do |j|
    next unless j - i > 1

    inner_values = values[i..j]
    if inner_values.sum == @invalid
      puts inner_values.min + inner_values.max
      break
    end
  end
end


