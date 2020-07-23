require_relative "game_data"
class GameStatistics

  def initialize
    @game_outcomes = {
      :home_games_won => 0,
      :visitor_games_won => 0,
      :ties => 0
    }
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
    ((@game_outcomes[:home_games_won].to_f / all_games.size) * 100).round(2)
  end

  def percentage_of_visitor_wins
    ((@game_outcomes[:visitor_games_won].to_f / all_games.size) * 100).round(2)
  end

  def percentage_of_ties

  end

end
