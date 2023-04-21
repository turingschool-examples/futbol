require_relative "./stat_tracker"
require_relative "./stat_helper"

class GameStatistics < StatHelper

  def initialize(files)
    super
  end

  def scores
    scores = @games.map { |game| (game.away_goals + game.home_goals)}
  end

  def highest_total_score
    scores.max
  end

  def lowest_total_score
    scores.min
  end

  def percentage_home_wins
    home_wins = 0
    @game_teams.find_all do |row|
      home_wins += 1 if (row[:hoa]) == "home" && row[:result] == "win" ||
      (row[:hoa]) =="away" && row[:result] == "loss"
    end
    (home_wins.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    @game_teams.find_all do |row|
      visitor_wins += 1 if (row[:hoa]) == "away" && row[:result] == "win" ||
      (row[:hoa]) =="home" && row[:result] == "loss"
    end
    (visitor_wins.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_ties
    no_lose = 0
    @game_teams.find_all do |row|
      no lose += 1 if (row[:hoa]) == "home" && row[:result] == "tie" ||
      (row[:hoa]) =="away" && row[:result] == "tie"
    end
    (no_lose.to_f / @game_teams.count. to_f).round(2)
  end

    # def count_of_games_by_season
  #   method
  # end

  # def average_goals_per_game
  #   method
  # end

  # def average_goals_by_season
  #   method
  # end
end
