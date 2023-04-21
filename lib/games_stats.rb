
require_relative "futbol"
class GamesStats < Futbol
  attr_reader 

  def initialize(locations)
    super(locations)
  end

  # highest sum of winning and losing teams score
  def highest_total_score
    # i want to find the game with the highest points scored and add the home score and away score.
    games.map do |game|
      game.away_team_goals + game.home_team_goals
    end.sort.last
  end

  def lowest_total_score
    games.map do |game|
      game.away_team_goals + game.home_team_goals
    end.sort.first
  end

  def count_of_games_by_season
    game_count = Hash.new(0)
    games.map do |game|
      game_count[game.season] += 1
    end
    game_count
  end

  def average_goals_per_game
    # all_season_goals = games.sum do |game|
    #   game.away_team_goals + game.home_team_goals
    # end
    all_season_goals.fdiv(games.length).round(2)
  end

  def average_goals_by_season
    season_goals.merge!(count_of_games_by_season) do |season, goals, games|
      goals.fdiv(games).round(2)
    end
    
      
      
    # creating a hash from an array
    # key = season
    # value = #avg_goals_game
    # combine above 2 methods?
    end
end

private

def all_season_goals
  games.sum do |game|
    game.away_team_goals + game.home_team_goals
  end
end