# frozen_string_literal: true

class Array
  def to_range
    first.send((last > first ? :upto : :downto), last)
  end
end

@values = File.open("#{File.dirname(__FILE__)}/input.txt", 'r').to_a.map do |line|
  values = line.chomp.split(/[^\d+]/).reject(&:empty?).map(&:to_i)
  @max = [@max || 0, values.max].max
  %i[x1 y1 x2 y2].zip(values).to_h
end
input = @values.select { |i| i[:x1] == i[:x2] || i[:y1] == i[:y2] }
@matrix = Array.new(@max + 1) { Array.new(@max + 1) { 0 } }
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

@matrix.map { |row| row.map { _1.zero? ? '--' : _1 } }
puts(@matrix.flatten.count { _1 > 1 })
