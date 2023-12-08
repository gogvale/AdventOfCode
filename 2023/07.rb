# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true).map(&:split)
$rules = [
  [/(.)\1{4}/], # Five of a kind
  [/(.)\1{3}/], # Four of a kind
  [/(.)\1{2}(.)\2/, /(.)\1(.)\2{2}/], # Full house (OR)
  [/(.)\1{2}/], # Three of a kind
  [/(.)\1.*(.)\2/], # Two pair
  [/(.)\1/], # One pair
  [/./] # High Card
]
$cards = '23456789TJQKA'

def to_array(hand)
  hand.split('').map { $cards.index(_1) }
end

def replace_joker(hand)
  return hand unless hand.scan(/J/)

  joker_indexes = hand.enum_for(:scan, 'J').map { Regexp.last_match.begin(0) }
  min = $rules.size
  $cards.split('').repeated_combination(joker_indexes.size).map do |combination|
    joker_indexes.zip(combination).each do |i, l|
      hand[i] = l
    end
    index = $rules.find_index { |rule| rule.any? { _1.match? hand } }
    min = index if index&.send(:<, min)
    [hand.dup, index]
  end.select { _2 == min }.map(&:first).sort { to_array(_1) <=> to_array(_2) }.last
end

def calculate_winnings(input, part2 = false)
  rankings = Array.new($rules.size) { [] }
  input.each do |hand, bid|
    hand = replace_joker(hand) if part2
    i = $rules.each_with_index.filter_map do |rule, index|
      index if rule.any? { |r| r.match? hand.split('').sort.join }
    end.first
    hand = to_array(hand)
    rankings[$rules.size - i - 1] << [hand, bid.to_i]
  end
  rankings.map do |block|
    block.sort.map { _2 }
  end.flatten.unshift(0).each_with_index.sum { _1 * _2 }
end

silver = calculate_winnings(input)
gold = calculate_winnings(input, true)

puts silver, gold