#!/usr/bin/env ruby

factor = 0.9

data  = []
copy = []


class Array
  def to_mma
    "{#{self.map{|x| x.class.method_defined?(:to_mma) ? x.to_mma : x.to_s}.join(",")} }"
  end
end


def rand_pos_at(x, y, r) 
	d = rand() * Math::PI * 2
	l = rand() * r
	[x + Math::cos(d) * l , y + Math::sin(d) *l ]
end

3000.times do ||
		r, s = rand_pos_at(1,1,1)
		data << [r, s, 1]
		copy << [r, s]
end

1000.times do ||
		r,s = rand_pos_at(3,3,1)
		data  << [r, s, 0]
		copy  << [r, s]
end

w = [[0, 0, 0]]

def dot(v1, v2) 
	v1[0]*v2[0] + v1[1]*v2[1]
end

data.shuffle!

data.each_with_index do |v, idx|
	curr_w = w.last
	d = dot(curr_w, v) + factor*curr_w[2]
	if v[2] == 0 && d >= 0 
		w << [curr_w[0] - factor* v[0],curr_w[1] - factor* v[1], curr_w[2] - factor* 1]
	elsif v[2] == 1 && d < 0
		w << [curr_w[0] + factor* v[0], curr_w[1] + factor* v[1], curr_w[2] + factor* 1]
	end
end

l = w.last

File.open("data.m","w") do |f|
	f.puts "a = "+ copy.to_mma
    f.puts "Show[Plot[-(#{l[2]} + #{l[0]} x) / #{l[1]} , {x, -1, 5}], ListPlot[a], PlotRange -> All]"
end
