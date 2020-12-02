file = File.open("input.txt")
input = file.readlines.map{|line| line.chomp}

def strip_string(string)
    arr =  string.split(": ")
    policy = arr.first
    password = arr.last
    policy = policy.split("-")
    min = policy.first.to_i
    policy = policy.last.split
    max = policy.first.to_i
    char = policy.last
    return min,max,char,password

end

def valid_password(string)
    min,max,char,password = strip_string(string)
    password.split("").count{|i| i==char}.between?(min,max)
end

def valid_password2(string)
    first,last,char,password = strip_string(string)
    (password[first-1] == char) ^ (password[last-1] == char)
end

puts input.count{|str| valid_password(str)}
puts input.count{|str| valid_password2(str)}

