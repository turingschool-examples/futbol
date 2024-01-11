require 'csv'
require_relative './stat_tracker'
require_relative './game'
require_relative './team'
require_relative './game_team'

class StatTracker
   def self.from_csv(location_path)

      StatTracker.new(location_path)
   end

   def initialize(locations_path)
      @data_games = read_games_csv(locations_path[:games])
      @data_teams = read_teams_csv(locations_path[:teams])
      @data_game_teams = read_game_teams_csv(locations_path[:game_teams])
   end

   def read_games_csv(location_path)
      games_data = []
      CSV.foreach(location_path, headers: true, header_converters: :symbol) do |row|
         game_details = {
            game_id: row[:game_id],
            season: row[:season],
            away_team_id: row[:away_team_id],
            home_team_id: row[:home_team_id],
            away_goals: row[:away_goals],
            home_goals: row[:home_goals]
         }
         games_data << Game.new(game_details)
      end
      games_data
   end

   def read_teams_csv(location_path)
      teams_data = []
      CSV.foreach(location_path, headers: true, header_converters: :symbol) do |row|
         team_id = row[:team_id]
         team_name = row[:team_name]
         teams_data << Team.new(team_id, team_name)
      end
      teams_data
   end

   def read_game_teams_csv(location_path)
      game_team_data = []
      CSV.foreach(location_path, headers: true, header_converters: :symbol) do |row|
         game_team_details = {
            game_id: row[:game_id],
            team_id: row[:team_id],
            hoa: row[:hoa],
            result: row[:result],
            head_coach: row[:head_coach],
            goals: row[:goals],
            shots: row[:shots],
            tackles: row[:tackles]
         }
         game_team_data << GameTeam.new(game_team_details)
      end
      game_team_data
   end

   def highest_total_score
      highest_score_game = @data_games.max_by do |game|
          game.away_goals + game.home_goals
      end
      highest_score_game.away_goals + highest_score_game.home_goals
   end

   def lowest_total_score
      lowest_score_game = @data_games.min_by do |game|
         game.away_goals + game.home_goals
     end
     lowest_score_game.away_goals + lowest_score_game.home_goals
   end

   def percentage_home_wins
      home_wins = @data_games.find_all do |game|
         game.home_goals > game.away_goals
      end
      calculate_percentage(home_wins.count , @data_games.count)
      # require'pry';binding.pry
   end

   def calculate_percentage(num1 , num2)
      ((num1.to_f / num2) * 100).round(2)
   end
end
