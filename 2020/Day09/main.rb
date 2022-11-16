values = File.open('input.txt', 'r').to_a.map { _1.chomp.to_i }
@index = 25
until @index == values.size
  preamble = values[@index - 25..@index]
  value = values[@index]
  unless preamble.permutation(2).map(&:sum).include?(value)
    puts value
    break
  end
  @index += 1
end

