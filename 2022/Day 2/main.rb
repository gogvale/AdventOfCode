# frozen_string_literal: true
opponent_hash = {
  "A" => :rock,
  "B" => :paper,
  "C" => :scissors
}

your_hash = {
  "X" => :rock,
  "Y" => :paper,
  "Z" => :scissors
}
your_correct_hash = {
  "X" => :lose,
  "Y" => :draw,
  "Z" => :win
}

def get_guess(opponent, outcome)
  return opponent if outcome == :draw

  case opponent
  when :rock
    outcome == :win ? :paper : :scissors
  when :paper
    outcome == :win ? :scissors : :rock
  when :scissors
    outcome == :win ? :rock : :paper
  end
end

def result(opponent, you)
  initial_score = { rock: 1, paper: 2, scissors: 3 }[you]
  return initial_score + 3 if opponent == you

  initial_score + case opponent
                  when :rock
                    you == :paper ? 6 : 0
                  when :paper
                    you == :scissors ? 6 : 0
                  when :scissors
                    you == :rock ? 6 : 0
                  end
end

def second_result(opponent, you)
  initial_score = { rock: 1, paper: 2, scissors: 3 }[you]
  return initial_score + 3 if opponent == you

  initial_score + case opponent
                  when :rock
                    you == :paper ? 6 : 0
                  when :paper
                    you == :scissors ? 6 : 0
                  when :scissors
                    you == :rock ? 6 : 0
                  end
end

@values = File.open("#{File.dirname(__FILE__)}/input.txt", 'r').to_a.map(&:split)
puts @values.map { result(opponent_hash[_1], your_hash[_2]) }.sum
puts @values.map { result(opponent_hash[_1], get_guess(opponent_hash[_1], your_correct_hash[_2])) }.sum
