require_relative "game_data"
class GameStatistics

  def initialize
    @game_outcomes = {
      :home_games_won => 0,
      :visitor_games_won => 0,
      :ties => 0
    }
    @total_games = all_games.size
    @games_per_season = Hash.new{ |hash, key| hash[key] = 0 }
  end

  def all_games
    GameData.create_objects
  end

  def total_score
    all_games.map do |games|
      games.home_goals + games.away_goals
    end
  end

  def highest_total_score
    total_score.max
  end

  def lowest_total_score
    total_score.min
  end

  def win_data
    all_games.map do |games|
      if games.home_goals > games.away_goals
        @game_outcomes[:home_games_won] += 1
      elsif games.home_goals < games.away_goals
        @game_outcomes[:visitor_games_won] += 1
      else
        @game_outcomes[:ties] += 1
      end
    end
  end

  def percentage_of_home_wins
    home_wins = @game_outcomes[:home_games_won]
    decimal_home = home_wins.to_f / @total_games
    (decimal_home * 100).round(2)
  end

  def percentage_of_visitor_wins
    visitor_wins = @game_outcomes[:visitor_games_won]
    decimal_visitor = visitor_wins.to_f / @total_games
    (decimal_visitor * 100).round(2)
  end

  def percentage_of_ties
    total_ties = @game_outcomes[:ties]
    decimal_ties = total_ties.to_f / @total_games
    (decimal_ties * 100).round(2)
  end

  def count_of_games_by_season
    all_games.each do |game|
      if @games_per_season.include?(game.season)
        @games_per_season[game.season] += 1
      else
        @games_per_season[game.season] = 1
      end
    end
    @games_per_season
  end

  def average_goals_per_game

  end

end
