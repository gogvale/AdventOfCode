
content = []
text = ""

File.open("input.txt", "r").each_line do |line|
    if line.length == 1
        content.push text.strip
        text = ""
    else
        text = text + " " + line.chomp
    end
end
def is_valid?(str)
    tags = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
    tags.each do |tag|
        return false if !str.any? tag
    end
    true
end


content = content.map{|str| str.split(":").map{|i| i[-3..]} }
puts content.map{|i| is_valid?i}.select{|i| i}.length




