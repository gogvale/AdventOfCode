# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true)

silver = input.filter_map do |line|
  game, cubes = line.split(': ')
  game[/\d+/].to_i if cubes.split(';').all? do |set|
    max_hash = { "red" => 12, "green" => 13, "blue" => 14 }
    set.strip.split(/,? /).reverse.each_slice(2).to_h.all? do |k, v|
      !(max_hash[k] - v.to_i).negative?
    end
  end
end.sum

gold = input.sum do |line|
  games = line.split(': ').last.split(';').map { _1.strip.split(/,? /).reverse.each_slice(2).to_h }
  %w[red green blue].map do |color|
    games.map do |game|
      game[color].to_i
    end.max
  end.reduce(:*)
end

puts silver, gold