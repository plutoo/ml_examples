#!/usr/bin/env ruby

$data = File.read("./pima-indians-diabetes.data").split("\n").map {|line| line.split(",")}


def psub(idx) 
    asso = $data.map {|item| [item[idx].to_i, item[8].to_i]}
end


def prat(idx)
    data = $data.map {|item| item[idx].to_i}
end

max = prat(1).max
min = prat(1).select{|x| x > 0}.min

all = []
count = 0
idx = min  

prepared_data = prat(1).select{|x| x > 0}.sort

prepared_data.each do |v| 
    while idx < v 
        # all << [idx, count]
        # puts "push _ #{idx}"
        all << [idx, ((1.0* count)/prepared_data.size).round(5)]
        idx += 1
    end
    count += 1
    if all.last && all.last[0] == v 
        # puts "duplicate value #{all.last}"
        all.last[1] =  ((1.0* count)/prepared_data.size).round(5)
    else
        # puts "push #{v}"
        all << [v, ((1.0* count)/prepared_data.size).round(5)]
    end
    idx += 1
    # all << [idx, count]
end

class Array
    def to_mma 
        "{" + self.map{|x| x.class.method_defined?(:to_mma) ? x.to_mma : x}.join(",")+ "}"
    end
end

File.write("data.m","a = #{all.to_mma};\nListPlot[a,GridLines -> Automatic]" )

File.write("raw.m", "x= #{psub(1).select{|x| x[1] == 0}.map{|x| x[0]}.to_mma};\ny = #{psub(1).select{|x| x[1] == 1}.map{|x| x[0]}.to_mma};")