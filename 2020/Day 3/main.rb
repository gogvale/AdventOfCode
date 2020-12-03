input = File.open("input.txt").readlines.map{|line| line.chomp}

def slope_trees(right,below,input)
    current = 0
    total_trees = 0
    input.each_with_index do |i,idx|
        next if idx % below != 0 or idx == 0
        current += right
        total_trees += 1 if i[current%i.size] == "#"
    end
    total_trees
end

# Exercise 1
puts slope_trees(3,1,input)

# Exercise 2
steps = [[1,1],[3,1],[5,1],[7,1],[1,2]]
puts steps.reduce(1){|total, i| total * slope_trees(i.first,i.last,input)}
