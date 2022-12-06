# frozen_string_literal: true

input = File.read("#{File.dirname(__FILE__)}/input.txt")
[4, 14].map do |num_chars|
  puts input.chars.each_cons(num_chars).to_a.index { _1.uniq.size == num_chars } + num_chars
end

