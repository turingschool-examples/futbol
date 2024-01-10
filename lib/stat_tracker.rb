require 'csv'

class StatTracker
   def self.from_csv(location)

      StatTracker.new(location)
   end

   def initialize(locations)
      @data_game = read_games_csv(locations[:games])
      @data_teams = read_teams_csv(locations[:teams])
      @data_game_teams = read_game_teams_csv(locations[:game_teams])
   end

   def read_games_csv(location)
      games_data = []
      CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
         game_id = row[:game_id]
         season = row[:season]
         away_team_id = row[:away_team_id]
         home_team_id = row[:home_team_id]
         away_goals = row[:away_goals]
         home_goals = row[:home_goals]
         
         games_data << Game.new(game_id, season, away_team_id, home_team_id, away_goals, home_goals)
      end
      games_data
   end
end
#equire 'CSV'
# headers: true & header_converter: :symbol are optional arguments
# CSV.foreach('./data/animal_lovers.csv', headers: true, header_converters: :symbol) do |row|
#    require 'pry'; binding.pry
#  end
end