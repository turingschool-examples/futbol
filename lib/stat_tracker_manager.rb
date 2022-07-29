require "csv"

puts "Stat_tracker initialized."
puts "=" * 100


##prints out csv with space and put into array##
# lines = File.readlines "data/teams.csv"
# lines.each do |line|
#   columns = line.split(",")
#   team_id = columns[0]
#   puts team_id
# end

## prints out csv without header###
# lines = File.readlines "data/teams.csv"
# row_index = 0
# lines.each do |line|
#   row_index = row_index + 1
#   next if row_index == 1
#   columns = line.split(",")
#   team_id = columns[0]
#   puts team_id
# end

##csv


# team_id_array = []

contents = CSV.open "data/teams.csv", headers: true, header_converters: :symbol
contents.map do |row|
  team_id = row[:team_id]
  franchiseid = row[:franchiseid]
  teamname = row[:teamname]
  abbreviation = row[:abbreviation]
  link = row[:link]
  puts "#{team_id} #{franchiseid} #{teamname} .... #{abbreviation} #{link}"
end
