# frozen_string_literal: true

input = IO.readlines("#{File.dirname(__FILE__)}/input.txt", chomp: true)

def find_next(values, source)
  values.filter_map do |value|
    source + value[0] - value[1] if (value[1]..value[1] + value[2]).include?(source)
  end.first || source
end

def find_previous(values, source)
  values.filter_map do |value|
    source + value[1] - value[0] if (value[0]..value[0] + value[2]).include?(source)
  end.first || source
end

seeds = input.first.scan(/\d+/).map(&:to_i)
almanac = [
  'seed-to-soil map:',
  'soil-to-fertilizer map:',
  'fertilizer-to-water map:',
  'water-to-light map:',
  'light-to-temperature map:',
  'temperature-to-humidity map:',
  'humidity-to-location map:'
].map do |line|
  i = input.find_index(line)
  values = []
  until input[i += 1].to_s.empty?
    values << input[i].scan(/\d+/).map(&:to_i)
  end
  values
end
silver = seeds.map do |seed|
  almanac.each do |values|
    seed = find_next(values, seed)
  end
  seed
end.min

almanac.reverse!
ranges = seeds.each_slice(2).map { (_1.._1 + _2) }
gold = (0..nil).find do |location|
  almanac.each do |values|
    location = find_previous(values, location)
  end
  ranges.any? { _1.include? location }
end - 1

puts silver, gold
