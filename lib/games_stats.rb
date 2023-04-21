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
      # require 'pry'; binding.pry
    end.sort.last
  end


  # count of games by season
  # =
  # has with season names as keys
  # counts of games as values
  # ex. 20122013 => 32

  def count_of_games_by_season
    game_count = Hash.new
    games.map do |game|   
      

    end

  end


end
