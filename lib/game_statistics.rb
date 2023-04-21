require_relative "./stat_tracker"
require_relative "./stat_helper"

class GameStatistics < StatHelper

  def initialize(files)
    super
  end

  def scores
    scores = @games.map { |game| (game.away_goals + game.home_goals)}
  end

  def highest_total_score
    scores.max
  end

  def lowest_total_score
    scores.min
  end

  def percentage_home_wins
    games_played = 0 
    home_games_won = 0
    @game_teams.map do |game_team|
      game_team.hoa
    end
  end

  # def percentage_visitor_wins
    
  # end

  # def percentage_ties
  #   method
  # end

  def count_of_games_by_season
    season_games_count = {}
    @games.each do |game|
      if season_games_count.keys.include?(game.season)
        season_games_count[game.season] += 1
      else
        season_games_count[game.season] = 1
      end
    end
    season_games_count
  end

  
  def average_goals_per_game
    total_goals = games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    (total_goals.sum / games.length.to_f).round(2)
  end
  # # Pseudocode:
  #   for each game (away_goals + home_goals)
  #   sum all games total goals
  #   divide by total number of games
  #   (rounded to the nearest 100th)
  #   return Float
  # Description: Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)
  # Return Value: Float


  # def average_goals_by_season
  #   season_goals = Hash.new { |h, k| h[k] = { home_goals: 0, away_goals: 0, games_played: 0 } }
    
  #   games.each do |game|
  #     season_goals[game.season][:home_goals] += game.home_goals.to_i
  #     season_goals[game.season][:away_goals] += game.away_goals.to_i
  #     season_goals[game.season][:count_of_games_by_season]
  #   end
    
  #   season_goals.transform_values do |goals|
  #     total_goals = goals[:home_goals] + goals[:away_goals]
  #     require 'pry'; binding.pry
  #     total_goals.to_f / goals[:count_of_games_by_season]
  #   end
  # end

  # # Pseudocode:
  #   separate season
  #   for each season: (away_goals + home_goals)
  #   create a hash (season => (total goals by season divided by season by count_of_games_by_season)
  #   (rounded to the nearest 100th)
  #   return Hash

  # Description: Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)
  # Return Value: Hash

end
