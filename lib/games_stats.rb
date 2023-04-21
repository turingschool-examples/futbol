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

  def lowest_total_score
    games.map do |game|
      game.away_team_goals + game.home_team_goals
    end.sort.first
  end

  def percentage_home_wins
    num_games = @games.length
    num_home_wins = @games.count do |game|
      game.home_result == "WIN"
    end
    (num_home_wins.to_f/num_games).round(2)
  end
  
  def percentage_visitor_wins
    num_games = @games.length
    num_visitor_wins = @games.count do |game|
      game.away_result == "WIN"
    end
    (num_visitor_wins.to_f/num_games).round(2)
  end
  
  def percentage_ties
    num_games = @games.length
    num_ties = @games.count do |game|
      game.away_result == "TIE" || game.home_result == "TIE"
    end
    (num_ties.to_f/num_games).round(2)
  end
end

