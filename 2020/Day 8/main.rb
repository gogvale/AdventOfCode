require "pry"
$input = File.open("input.txt").readlines.map(&:chomp).map{|i| i.split}
acc = 0

instr_number = 0
next_instr_number = instr_number
instructions_list = []
$change =[]
$i = 0

while true
    instr, value = $input[instr_number]
    if instr == 'acc'
        acc += value.to_i
        next_instr_number += 1
    elsif instr == 'nop'
        next_instr_number += 1
        $change << instr_number
    elsif instr== 'jmp'
        next_instr_number = instr_number + value.to_i
        $change << instr_number
    end
    break if instructions_list.include? next_instr_number or next_instr_number >= $input.length
    instructions_list << next_instr_number
    instr_number = next_instr_number
end

puts acc #2058
#  ------------------

puts acc 
#4116
#4170