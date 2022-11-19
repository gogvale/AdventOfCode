# frozen_string_literal: true

class Board
  LENGTH = 5
  attr_reader :array, :modified, :checks

  def initialize(array)
    @checks = {}
    @array = array
  end

  def check_for_number(number)
    @array.each.with_index do |row, row_number|
      if row.any? number
        @checks[number] = [row_number, row.index(number)]
        @modified = true
        return true
      end
    end
    false
  end

  def finished?
    return false if @checks.size < LENGTH

    values = @checks.values
    rows, columns = values.transpose
    rows.uniq.any? { rows.count(_1) == LENGTH } ||
      columns.uniq.any? { columns.count(_1) == LENGTH } #||
      # ((0..4).map { [_1, _1] }.to_a & values).length == LENGTH ||
      # ([[0, 4], [1, 3], [2, 2], [3, 1], [4, 0]] & values).length == LENGTH
  end

  def sum_unchecked
    values = @checks.values
    rows = @array.map.with_index do |i, row|
      i.reject.with_index { |_, column| values.include?([row, column]) }.map(&:to_i).sum
    end
    rows.sum
  end

  def reset!
    @modified = false
  end

  def modified?
    @modified
  end
end

@values = File.open("#{File.dirname(__FILE__)}/input.txt", 'r').to_a.map { _1.chomp }
draws = @values.first.split(',')
boards = (2..@values.length).step(6).map { @values[_1.._1 + 4].map(&:split) }.map { Board.new(_1) }
draws.each do |draw|
  modified_boards = boards.each { _1.check_for_number(draw) }.select(&:modified?)
  finished_board = modified_boards.select(&:finished?)
  if finished_board.any?
    @winning_board = finished_board.first
    @last_draw = draw
    break
  else
    modified_boards.each(&:reset!)
  end
end

puts @winning_board.sum_unchecked * @last_draw.to_i
