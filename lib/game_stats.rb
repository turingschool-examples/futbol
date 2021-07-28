require './lib/stat_tracker'

class GameStats < StatTracker
  attr_reader :games

  def initialize(games)
    @games = games
  end

  def highest_total_score
    top_score = @games.map do |game|
      game.away_goals + game.home_goals
    end
    top_score.max
  end

  def lowest_total_score
    bottom_score = @games.map do |game|
      game.away_goals + game.home_goals
    end
    bottom_score.min
  end

  def percentage_home_wins
    hwins = []
    @games.map do |game|
      if game.home_goals > game.away_goals
        hwins << game
      end
    end
    hwins.length.fdiv(@games.length).round(2)
  end

  def percentage_visitor_wins
    awins = []
    @games.map do |game|
      if game.away_goals > game.home_goals
        awins << game
      end
    end
    awins.length.fdiv(@games.length).round(2)
  end

  def percentage_ties
    ties = []
    @games.map do |game|
      if game.away_goals == game.home_goals
        ties << game
      end
    end
    ties.length.fdiv(@games.length).round(2)
  end

  def count_of_games_by_season
    games_bs = {}
    # Here we're looking to create a hash where the key is the season ID and the value is the total games
    @games.each do |game|
    end
    games_bs
  end

  def average_goals_per_game
    goals = @games.map do |game|
      game.away_goals + game.home_goals
    end
    goals.sum.fdiv(@games.length).round(2)
  end

  def average_goals_by_season
    goals_bs = {}
    # This is a hash where key is season ID and value is average goals
    goals_bs
  end
end
