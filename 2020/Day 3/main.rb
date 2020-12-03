$input = File.open("input.txt").readlines.map(&:chomp)

def slope_trees(right,below)
    current = 0
    total_trees = 0
    $input.each_with_index do |i,idx|
        next if idx % below != 0 or idx == 0
        current += right
        total_trees += 1 if i[current%i.size] == "#"
    end
    total_trees
end

# Exercise 1
puts slope_trees(3,1)

# Exercise 2
slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]]
puts slopes.reduce(1){|total, i| total * slope_trees(i.first,i.last)}
