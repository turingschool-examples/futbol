require_relative './stat_tracker'

class GameStatistics
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def highest_total_score
    highest_scoring_game =
    @data.games.max_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    highest_scoring_game[:away_goals].to_i + highest_scoring_game[:home_goals].to_i
  end

  def lowest_total_score
    lowest_scoring_game =
    @data.games.min_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    lowest_scoring_game[:away_goals].to_i + lowest_scoring_game[:home_goals].to_i
  end

  def percentage_home_wins
    (home_team_wins.fdiv(@data.games.length) * 100).round(2)
  end

  def percentage_visitor_wins
    (visitor_team_wins.fdiv(@data.games.length) * 100).round(2)
  end

  def percentage_ties
    (ties.fdiv(@data.games.length) * 100).round(2)
  end

  def home_team_wins
    home_wins =
    @data.games.count do |game|
      game[:home_goals] > game[:away_goals]
    end
    home_wins
  end

  def visitor_team_wins
    visitor_wins =
    @data.games.count do |game|
      game[:home_goals] < game[:away_goals]
    end
    visitor_wins
  end

  def ties
    ties =
    @data.games.count do |game|
      game[:home_goals] == game[:away_goals]
    end
    ties
  end
end
