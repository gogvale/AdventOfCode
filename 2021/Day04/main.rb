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

    @checks.values.transpose.any? { |i| i.uniq.any? { i.count(_1) == LENGTH } }
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
boards = (2..@values.length).step(6).map { Board.new(@values[_1.._1 + 4].map(&:split)) }
boards_length = boards.length
draws.each do |draw|
  modified_boards = boards.each { _1.check_for_number(draw) }.select(&:modified?)
  modified_boards.select(&:finished?).each do |board|
    puts board.sum_unchecked * draw.to_i if [1, boards_length].include?(boards.length)

    boards.delete(board)
  end
  boards.empty? ? break : modified_boards.each(&:reset!)
end
