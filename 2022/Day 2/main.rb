@logic = { # Lose, Draw, Win, Score
           "X" => ["B", "A", "C", 1],
           "Y" => ["C", "B", "A", 2],
           "Z" => ["A", "C", "B", 3],
}

def get_guess(opponent, outcome)
  @logic.find { _2[["X", "Y", "Z"].index(outcome)] == opponent }.first
end

def result(opponent, you)
  @logic[you][-1] + 3 * @logic[you].index(opponent)
end

@values = File.open("#{File.dirname(__FILE__)}/input.txt", 'r').to_a.map(&:split)
puts @values.sum { result(_1, _2) }
puts @values.sum { result(_1, get_guess(_1, _2)) }
