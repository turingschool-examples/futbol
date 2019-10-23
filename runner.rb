require 'csv'

csv = CSV.read("./data/teams.csv", headers: true, header_converters: :symbol)
require "pry"; binding.pry
csv.map do |row|
  puts row
end
