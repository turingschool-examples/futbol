animals = [:dog, :cat, :zebra, :quokka, :unicorn, :bear]
animal_s = animals.map do |animal|
  animal.to_s
end

#p animal_s

sorted = animal_s.select {|animal| animal.length >= 4 }

#p sorted
hash = Hash.new()
p animal_s.map {|animal| Hash[animal.to_sym, animal.length] }.inject(:merge)
animal_s.map {|animal| hash[animal.to_sym] = animal.length }
p hash
p Hash[animal_s.collect{|animal| [animal.to_sym, animal.length]}]
require 'pry'; binding.pry



