# frozen_string_literal: true

class Array
  def to_range
    first.send((last > first ? :upto : :downto), last)
  end
end

@values = File.open("#{File.dirname(__FILE__)}/input.txt", 'r').to_a.map do |line|
  values = line.scan(/\d+/).map(&:to_i)
  @max = [@max || 0, values.max].max
  %i[x1 y1 x2 y2].zip(values).to_h
end
@matrix = Array.new(@max + 1) { Array.new(@max + 1) { 0 } }

input = @values.select { |i| i[:x1] == i[:x2] || i[:y1] == i[:y2] }
input.each do |coord|
  [coord[:x1], coord[:x2]].to_range.each do |x|
    [coord[:y1], coord[:y2]].to_range.each do |y|
      @matrix[y][x] += 1
    end
  end
end
puts(@matrix.flatten.count { _1 > 1 })

input = @values - input
input.each do |coord|
  [coord[:x1], coord[:x2]].to_range.zip([coord[:y1], coord[:y2]].to_range).each do |x, y|
    @matrix[y][x] += 1
  end
end
puts(@matrix.flatten.count { _1 > 1 })
