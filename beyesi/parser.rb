#!/usr/bin/env ruby

$data = File.read("./pima-indians-diabetes.data").split("\n").map {|line| line.split(",")}


def psub(idx) 
    asso = $data.map {|item| [item[idx].to_f, item[8].to_f]}
end


def prat(idx)
    data = psub(idx)
    data.count_
end

puts prat(1)