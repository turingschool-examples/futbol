require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require 'CSV'

class StatTracker
    attr_reader :games, :teams, :game_teams

    def initialize
      @games = []
      @teams = []
      @game_teams = []
    end

    def self.from_csv(locations)
       # Create a new instance of the StatTracker class
      stat_tracker = StatTracker.new
      # Call the load_games method on the new StatTracker instance
      # Pass in the value associated with the :games key from the locations hash
      # This value should be the file path to the games CSV file
      stat_tracker.load_games(locations[:games])
      stat_tracker.load_teams(locations[:teams])
      stat_tracker.load_game_teams(locations[:game_teams])
      stat_tracker
    end
    
    def load_games(file_path)
      CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
        @games << Game.new(
            row[:game_id].to_i,
            row[:season],
            row[:type],
            row[:date_time],
            row[:away_team],
            row[:home_team_id],
            row[:away_goals].to_i,
            row[:home_goals].to_i,
            row[:venue],
            row[:venue_link]
        )
      end
    end

    def load_teams(file_path)
      CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
        @teams << Team.new(
          row[:team_id], 
          row[:franchiseid], 
          row[:teamname], 
          row[:abbreviation], 
          row[:stadium], 
          row[:link]
          )
      end
    end

    def load_game_teams(file_path)
      CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
        @game_teams << GameTeam.new(
          row[:game_id], 
          row[:team_id], 
          row[:hoa], 
          row[:result], 
          row[:settled_in], 
          row[:head_coach], 
          row[:goals].to_i, 
          row[:shots].to_i, 
          row[:tackles].to_i, 
          row[:pim].to_i, 
          row[:powerplayopportunities].to_i, 
          row[:powerplaygoals].to_i, 
          row[:faceoffwinpercentage].to_f, 
          row[:giveaways].to_i, 
          row[:takeaways].to_i)
      end
    end

    def total_goals
      goals_array= @games.map do |game|
        game.away_goals + game.home_goals
    end
    goals_array
    end

    def highest_total_score
      highest = total_goals.max
      highest
    end

    def lowest_total_score
      lowest = total_goals.min
      lowest
    end

    def count_of_games_by_season
      games_by_season = {}

      @games.each do |game|
        if games_by_season[game.season]
          games_by_season[game.season] += 1
        else
          games_by_season[game.season] = 1
        end
      end
      games_by_season
    end

    def average_goals_per_game
      total_goals.sum / @games.size.to_f
    end
end