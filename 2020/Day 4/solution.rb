passports = DATA.read.lines.map(&:strip).chunk_while do |before, _|
    before.size > 0
  end.map do |passport|
    passport.join(" ").split(" ").map do |field|
      field.split ":"
    end.to_h
  end
  
  required_fields = %w(byr iyr eyr hgt hcl ecl pid)
  
  valid = passports.select do |passport|
    required_fields - passport.keys == []
  end
  
  puts valid.count # 250
  
  strict_valid = valid.select do |p|
    t1 = (1920..2002) === p["byr"].to_i
    t2 = (2010..2020) === p["iyr"].to_i
    t3 = (2020..2030) === p["eyr"].to_i
    h  = p["hgt"]
    t4 = h =~ /cm$/ && (150..193) === h.to_i
    t5 = h =~ /in$/ && (59..76) === h.to_i
    t6 = p["hcl"] =~ /^#[a-f\d]{6}$/
    t7 = p["pid"] =~ /^\d{9}$/
    t8 = "amb blu brn gry grn hzl oth".include? p["ecl"]
  
    [t1, t2, t3, (t4 || t5), t6, t7, t8].all?
  end
  
  puts strict_valid.count # 158
  
  __END__
  eyr:2024 pid:662406624 hcl:#cfa07d byr:1947 iyr:2015 ecl:amb hgt:150cm
  