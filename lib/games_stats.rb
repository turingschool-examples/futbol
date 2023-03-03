require 'stats'

class GamesStats < Stats 
  
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

  ###this can definitely be refactored###
  def percentage_home_wins
    home_wins = []
    @games.each do |game|
      if game.home_goals.to_i > game.away_goals.to_i
        home_wins << game
      end
    end
    home_percent_wins = home_wins.length.fdiv(@games.length).round(2)
  end

  ###this can definitely be refactored###
  def percentage_visitor_wins
    away_wins = []
    @games.each do |game|
      if game.away_goals.to_i > game.home_goals.to_i
        away_wins << game
      end
    end
    away_percent_wins = away_wins.length.fdiv(@games.length).round(2)
  end

  ###this can definitely be refactored###
  def percentage_ties
    tie_game = []
    @games.each do |game|
      if game.away_goals.to_i == game.home_goals.to_i
        tie_game << game
      end
    end
    tie_percent = tie_game.length.fdiv(@games.length).round(2)
  end

  ###this can definitely be refactored###
  def count_games_by_season
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
### Please god refactor this method while we work###
  def average_goals_by_season
    final_average_goals = {}
    goals_by_season = Hash.new(0)
    @games.each do |game|
    goals_by_season[game.season_year] += game.total_score
    end
    goals_by_season.map do |season1, goals|
      count_games_by_season.each do |season2, games|
        if season1 == season2
          final_average_goals[season1] = goals.fdiv(games).round(2)
        end
      end
    end
   final_average_goals
  end
end