require_relative './games_collection'
require_relative './teams_collection'
require_relative './game_teams_collection'


class StatTracker < DataLibrary

  def initialize(locations)
    super
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    highest = @games.max_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    highest[:away_goals].to_i + highest[:home_goals].to_i
  end

  def lowest_total_score
    lowest = @games.min_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    lowest[:away_goals].to_i + lowest[:home_goals].to_i
  end

  def percentage_home_wins
    home_wins = @games.count do |game|
      game[:home_goals] > game[:away_goals]
    end
    (home_wins.to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game[:home_goals] < game[:away_goals]
    end
    (visitor_wins.to_f / @games.length).round(2)
  end

  def percentage_ties
    ties = @games.count do |game|
      game[:home_goals] == game[:away_goals]
    end
    (ties.to_f / @games.length).round(2)
  end

  def count_of_games_by_season
    seasons = Hash.new(0)
    @games.each do |game|
      seasons[game[:season]] += 1
    end
    seasons
  end

  def average_goals_per_game
    total_goals = @games.sum do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    (total_goals.to_f / @games.count).round(2)
  end

  def average_goals_by_season
    seasons = Hash.new(0)
    @games.each do |game|
      seasons[game[:season]] += (game[:away_goals].to_i + game[:home_goals].to_i)
    end
    count_of_games_by_season.merge(seasons) do |key, games_count, total_goals|
      (total_goals.to_f / games_count).round(2)
    end
  end

  def count_of_teams
  end

  def best_offense
  end

  def worst_offense
  end

  def highest_scoring_visitor
  end

  def highest_scoring_home_team
  end

  def lowest_scoring_visitor
  end

  def lowest_scoring_home_team
  end

  def team_info
  end

  def best_season
  end

  def worst_season
  end

  def average_win_percentage
  end

  def most_goals_scored
  end

  def fewest_goals_scored
  end

  def favorite_opponent
  end

  def rival
  end

  def winningest_coach
  end

  def worst_coach
  end

  def most_accurate_team
  end

  def least_accurate_team
  end

  def most_tackles
  end

  def fewest_tackles
  end

end
