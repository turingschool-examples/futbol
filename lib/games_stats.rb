
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
    @games.map do |game|
      game_count[game.season] += 1
    end
    game_count
  end


end
