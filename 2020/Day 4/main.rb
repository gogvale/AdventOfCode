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
content.push text.strip unless text == ""


tags = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]

puts content.map{|str| str.split.map{|i| i.split(":").first} }
.select{|str_tags| (tags - str_tags).length.zero? }.length
content = content.select do |i|
  i.split.map{|str| str.split.map{|i| i.split(":").first} }
    .map{|str_tags| (tags - str_tags).length.zero? }
end




content = content.map{|i| i.split(/[:,\s]/)}.map{|i| Hash[*i]}
  .select do |p|
    t1 = (1920..2002) === p["byr"].to_i
    t2 = (2010..2020) === p["iyr"].to_i
    t3 = (2020..2030) === p["eyr"].to_i
    h  = p["hgt"]
    t4 = h =~ /cm$/ && (150..193) === h.to_i
    t5 = h =~ /in$/ && (59..76) === h.to_i
    t6 = p["hcl"] =~ /^#[a-f\d]{6}$/
    t7 = p["pid"] =~ /^\d{9}$/
    t8 = %w(amb blu brn gry grn hzl oth).include? p["ecl"]

    [t1, t2, t3, (t4 || t5), t6, t7, t8].all?
  end

puts content.length
# def valid_input?(str_tags)



