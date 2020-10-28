# require_relative './games_collection'
# require_relative './teams_collection'
# require_relative './game_teams_collection'
require_relative './data_library'


class StatTracker < DataLibrary

  def initialize(locations)
    super
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score #spec harness method
    highest = @games.max_by do |game|
      game[:total_score]
    end
    highest[:total_score]
  end

  def lowest_total_score
    lowest = @games.min_by do |game|
      game[:total_score]
    end
    lowest[:total_score]
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
      game[:total_score]
    end
    (total_goals.to_f / @games.count).round(2)
  end

  def average_goals_by_season
    seasons = Hash.new(0)
    @games.each do |game|
      seasons[game[:season]] += (game[:total_score])
    end
    count_of_games_by_season.merge(seasons) do |key, games_count, total_goals|
      (total_goals.to_f / games_count).round(2)
    end
  end

  def count_of_teams
    @teams.count
  end

  def total_goals
    home_goals = Hash.new(0)
    away_goals = Hash.new(0)
    @game_teams.each do |game_team|
      if game_team[:hoa] == "home"
        home_goals[game_team[:team_id]] += game_team[:goals].to_f
      else
        away_goals[game_team[:team_id]] += game_team[:goals].to_f
      end
    end
    total_goals = home_goals.merge(away_goals) do |key, home, away|
      {:home => home, :away => away, :total => home + away}
    end
  end

  def best_offense
    best = total_goals.max_by do |key, value|
      value[:total]
    end
    @teams.find do |team|
      if team[:team_id] == best[0]
        return team[:team_name]
      end
    end
  end

  def worst_offense
    worst = total_goals.min_by do |key, value|
      value[:total]
    end
    @teams.find do |team|
      if team[:team_id] == worst[0]
        return team[:team_name]
      end
    end
  end

  def highest_scoring_visitor
    best = total_goals.max_by do |key, value|
      value[:away]
    end
    @teams.find do |team|
      if team[:team_id] == best[0]
        return team[:team_name]
      end
    end
  end

  def highest_scoring_home_team
    best = total_goals.max_by do |key, value|
      value[:home]
    end
    @teams.find do |team|
      if team[:team_id] == best[0]
        return team[:team_name]
      end
    end
  end

  def lowest_scoring_visitor
    worst = total_goals.min_by do |key, value|
      value[:away]
    end
    @teams.find do |team|
      if team[:team_id] == worst[0]
        return team[:team_name]
      end
    end
  end

  def lowest_scoring_home_team
    worst = total_goals.min_by do |key, value|
      value[:home]
    end
    @teams.find do |team|
      if team[:team_id] == worst[0]
        return team[:team_name]
      end
    end
  end

  def team_info(team_id)
    info = @teams.find do |team|
      team[:team_id] == team_id
    end
    info.delete(:stadium)
    info.transform_keys do |key|
      key.to_s
    end
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
