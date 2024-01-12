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
      @data_game = read_games_csv(locations_path[:games])
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

   def count_of_teams
      @data_teams.count  
   end

   def best_offense
      team_stats = Hash.new {|hash, key| hash[key] = {goals: 0, games_played: 0 }}
      @data_game_teams.each do |game_team|
         team_stats[game_team.team_id][:goals] += game_team.goals
         team_stats[game_team.team_id][:games_played] += 1
      end

      team_averages = team_stats.transform_values do |stats|
         stats[:goals].to_f / stats[:games_played]
      end
      
      highest_average_team_id = team_averages.max_by {|_team_id, average| average}.first
      highest_average_team_name = "0"

      @data_teams.each do |team| 
         if team.team_id == highest_average_team_id
            highest_average_team_name = team.team_name
         end 
      end
      highest_average_team_name
   end

   def worst_offense
      team_stats = Hash.new {|hash, key| hash[key] = {goals: 0, games_played: 0 }}
      @data_game_teams.each do |game_team|
         team_stats[game_team.team_id][:goals] += game_team.goals
         team_stats[game_team.team_id][:games_played] += 1
      end

      team_averages = team_stats.transform_values do |stats|
         stats[:goals].to_f / stats[:games_played]
      end
      
      lowest_average_team_id = team_averages.min_by {|_team_id, average| average}.first
      lowest_average_team_name = "0"

      @data_teams.each do |team| 
         if team.team_id == lowest_average_team_id
            lowest_average_team_name = team.team_name
         end 
      end
      lowest_average_team_name
   end

   def highest_scoring_visitor
      away_team_stats = Hash.new {|hash, key| hash[key] = {goals: 0, games_played: 0 }}
      @data_game_teams.each do |game_team|
         if game_team.hoa == "away"
            away_team_stats[game_team.team_id][:goals] += game_team.goals
            away_team_stats[game_team.team_id][:games_played] += 1
         end
      end

      away_team_averages = away_team_stats.transform_values do |stats|
         stats[:goals].to_f / stats[:games_played]
      end

      highest_average_away_team_id = away_team_averages.max_by {|_team_id, average| average}.first
      highest_average_away_team_name = "0"

      @data_teams.each do |team| 
         if team.team_id == highest_average_away_team_id
            highest_average_away_team_name = team.team_name
         end 
      end
      highest_average_away_team_name
   end

   def highest_scoring_home_team
      home_team_stats = Hash.new {|hash, key| hash[key] = {goals: 0, games_played: 0 }}
      @data_game_teams.each do |game_team|
         if game_team.hoa == "home"
            home_team_stats[game_team.team_id][:goals] += game_team.goals
            home_team_stats[game_team.team_id][:games_played] += 1
         end
      end

      home_team_averages = home_team_stats.transform_values do |stats|
         stats[:goals].to_f / stats[:games_played]
      end
      
      highest_average_home_team_id = home_team_averages.max_by {|_team_id, average| average}.first
      highest_average_home_team_name = "0"

      @data_teams.each do |team| 
         if team.team_id == highest_average_home_team_id
            highest_average_home_team_name = team.team_name
         end 
      end
      highest_average_home_team_name
   end

   def lowest_scoring_visitor
         away_team_stats = Hash.new {|hash, key| hash[key] = {goals: 0, games_played: 0 }}
         @data_game_teams.each do |game_team|
            if game_team.hoa == "away"
            away_team_stats[game_team.team_id][:goals] += game_team.goals
            away_team_stats[game_team.team_id][:games_played] += 1
            end
         end
         away_team_averages = away_team_stats.transform_values do |stats|
            stats[:goals].to_f / stats[:games_played]
         end
         lowest_average_away_team_id = away_team_averages.min_by {|_team_id, average| average}.first
         lowest_average_away_team_name = "0"
         @data_teams.each do |team| 
               if team.team_id == lowest_average_away_team_id
               lowest_average_away_team_name = team.team_name
               end 
         end
         lowest_average_away_team_name
   end

   def lowest_scoring_home_team
      home_team_stats = Hash.new {|hash, key| hash[key] = {goals: 0, games_played: 0 }}
      @data_game_teams.each do |game_team|
         if game_team.hoa == "home"
         home_team_stats[game_team.team_id][:goals] += game_team.goals
         home_team_stats[game_team.team_id][:games_played] += 1
         end
      end
      home_team_averages = home_team_stats.transform_values do |stats|
         stats[:goals].to_f / stats[:games_played]
      end
      
      lowest_average_home_team_id = home_team_averages.min_by {|_team_id, average| average}.first
      lowest_average_home_team_name = "0"
      @data_teams.each do |team| 
            if team.team_id == lowest_average_home_team_id
            lowest_average_home_team_name = team.team_name
            end 
      end
      lowest_average_home_team_name
   end
end
