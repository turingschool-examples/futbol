require 'csv'
require './lib/stat_tracker'
require './lib/game_stat_module'

class GameStatistics 
  include GameStatsable

  def initialize(locations)
    @locations = locations
    @games_data = CSV.read(@locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(@locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(@locations[:game_teams], headers: true, header_converters: :symbol)
    
    @game_location = game_location
  
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  # Game statistics 
  def highest_total_score
    goals_scored.max
  end

  def lowest_total_score
    goals_scored.min
  end

  def percentage_home_wins
    percentage_wins_for_team_playing(home_or_away)
    wins = 0
    total_games = 0

    @game_teams_data.each do |row|
        if row[:hoa] == @game_location
          
          if row[:result] == 'WIN'
            wins += 1
            total_games += 1
        
          elsif row[:result] == 'LOSS' 
            total_games += 1

          elsif row[:result] == 'TIE'
            total_games += 1
          end
        end
    end
      (wins / total_games.to_f).round(2)
  end

  def percentage_visitor_wins
    wins = 0
    total_games = 0

    @game_teams_data.each do |row|
        if row[:hoa] == 'away'
          
          if row[:result] == 'WIN'
            wins += 1
            total_games += 1
        
          elsif row[:result] == 'LOSS' 
            total_games += 1

          elsif row[:result] == 'TIE'
            total_games += 1
          end
        end
    end
      (wins / total_games.to_f).round(2)
  end

  def percentage_ties
    tie = 0
    total_games = 0

    @game_teams_data.each do |row|
        if row[:hoa] == 'away'
          
          if row[:result] == 'TIE'
            tie += 1
            total_games += 1
          elsif row[:result] == 'LOSS' 
            total_games += 1
          elsif row[:result] == 'WIN'
            total_games += 1
          end
        end
    end
      (tie / total_games.to_f).round(2)
  end

  def count_of_games_by_season    
    season_games = {}

    seasons = @games_data.map do |row|
      row[:season] 
    end
    seasons = seasons.uniq!
  
    seasons.each do |season|
      season_games[season] = 0
    end

    season_games.each do |season, games|
        @games_data.each do |row|
          # require 'pry';binding.pry
          if row[:season] == season
            season_games[season] += 1
          end 
        end
    end
    return season_games
  end

  def average_goals_per_game
    total_games = []
    @games_data.each do |row|
      total_games << row[:game_id]
    end
    total_goals = 0
    @games_data.each do |row|
      total_goals += (row[:away_goals].to_i + row[:home_goals].to_i)
    end
    (total_goals.to_f / total_games.count).round(2)
  end

  def average_goals_by_season
    seasons = Hash.new()
    @games_data.each do |row|
      seasons[row[:season]] = []
    end
    @games_data.each do |row|
      seasons[row[:season]] << (row[:away_goals].to_i + row[:home_goals].to_i)
    end
    average_goals_by_season = Hash.new()
    seasons.each do |season, goals|
      average_goals_by_season[season] = (goals.sum.to_f / goals.length).round(2)  
    end
    average_goals_by_season
  end
end 