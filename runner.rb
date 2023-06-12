require './lib/stat_tracker'
require "csv"

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}
#require 'pry'; binding.pry
def list_out
  id = @csv[0].index("id")
  first_Name = @csv[0].index("first_Name")
  last_Name = @csv[0].index("last_Name")
  zipcode = @csv[0].index("Zipcode")
   new_arr = @csv.map do |attendee|
   Attendee.new(attendee[id], attendee[first_Name], attendee[last_Name], attendee[zipcode])
   end
   new_arr.drop(1)
end

p CSV.parse(File.read('./data/teams.csv'), headers: true)

#p CSV.read './data/teams.csv'#, headers: true
#contents = CSV.read './teams.csv'#, headers: true, header_converters: :symbol
#p stat_tracker = StatTracker.from_csv(locations)

#p locations

require 'pry'; binding.pry