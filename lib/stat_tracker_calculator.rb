require_relative './game'
require_relative './game_factory'
require_relative './team'
require_relative './team_factory'
require_relative './game_teams'
require_relative './game_teams_factory'
class StatTrackerCalculator
  attr_reader :game_factory,
              :team_factory,
              :game_teams_factory

  def initialize
    @game_factory = ""
    @team_factory = ""
    @game_teams_factory = ""
  end

  def highest_total_score
    @game_factory.total_score.max
  end

  def lowest_total_score
    @game_factory.total_score.min
  end

  def percentage_home_wins
    (@game_teams_factory.game_result_by_hoa.count {|result| result == "home"}.to_f / @game_factory.count_of_games.to_f).round(2)
  end

  def percentage_visitor_wins
    (@game_teams_factory.game_result_by_hoa.count {|result| result == "away"}.to_f / @game_factory.count_of_games.to_f).round(2)
  end

  def percentage_ties
    (@game_teams_factory.game_results_count_by_result("TIE").to_f / @game_factory.count_of_games.to_f).round(2)
  end

  def count_of_games_by_season
    count_of_games_by_season = {}
    @game_factory.games.each do |game|
      count_of_games_by_season[game.season] = @game_factory.season_games(game.season)
    end
    count_of_games_by_season
  end

  def average_goals_per_game
    (@game_factory.total_score.sum.to_f / @game_factory.count_of_games.to_f).round(2)
  end
end