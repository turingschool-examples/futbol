require_relative 'stats'

class GameStats < Stats 
  
  def initialize(files)
    super
  end

  def highest_total_score
    high_score = @games.max_by{ |game| game.total_score }
    high_score.total_score
  end

  def lowest_total_score
    low_score = @games.min_by{ |game| game.total_score }
    low_score.total_score
  end

  def percentage_home_wins
   all_home_wins.length.fdiv(@games.length).round(2)
  end

  def all_home_wins
    home_wins = []
    @games.each do |game|
      home_wins << game if game.home_goals.to_i > game.away_goals.to_i
    end
    home_wins
  end

  def percentage_visitor_wins
    all_away_wins.length.fdiv(@games.length).round(2)
  end

  def all_away_wins
    away_wins = []
    @games.each do |game|
      away_wins << game if game.away_goals.to_i > game.home_goals.to_i
    end
    away_wins
  end

  def percentage_ties
    all_ties.length.fdiv(@games.length).round(2)
  end

  def all_ties
    tie_game = []
    @games.each do |game|
      tie_game << game if game.away_goals.to_i == game.home_goals.to_i
    end
    tie_game
  end

  def count_of_games_by_season
    count = Hash.new(0)
    @games.map do |game|
      count[game.season_year] += 1
    end
    count
  end

  def average_goals_per_game
    sum_of_scores = @games.sum do |game|
      game.total_score
    end
    sum_of_scores.fdiv(@games.length).round(2)
  end

  def average_goals_by_season
    goals_by_season.merge!(count_of_games_by_season) do |season, goals, games| 
      goals.fdiv(games).round(2)
    end
  end

  def goals_by_season
    season_goals = Hash.new(0)
    @games.each do |game|
      season_goals[game.season_year] += game.total_score
    end
    season_goals
  end
end