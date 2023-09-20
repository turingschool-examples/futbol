require "csv"

class StatTracker
  attr_accessor :games_data, :teams_data, :game_teams_data

  def self.from_csv(locations)
    games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    new(games_data, teams_data, game_teams_data)
  end

  def initialize(games_data, teams_data, game_teams_data)
    @games_data = games_data
    @teams_data = teams_data
    @game_teams_data = game_teams_data
  end

  def total_scores
    @games_data.map { |game| game[:home_goals].to_i + game[:away_goals].to_i }
  end

  def highest_total_score
    total_scores.max
  end

  def lowest_total_score
    total_scores.min
  end

  def percentage_home_wins
    games = @games_data.length

    home_wins = @games_data.count { |game| game[:home_goals].to_i > game[:away_goals].to_i }

    (home_wins.to_f / games * 100.0).round(1)
  end

  def percentage_visitor_wins
    100.0 - percentage_home_wins - percentage_ties
  end

  def percentage_ties
    games = @games_data.length
    return 0.0 if games == 0
    ties = @games_data.count {|game| game[:away_goals].to_i == game[:home_goals].to_i}

    (ties.to_f / games * 100.0).round(1)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)

    @games_data.each do |game|
      season = game[:season]
      games_by_season[season] += 1
    end

    games_by_season
  end

  def average_goals_per_game
    total_goals = 0
    total_games = @games_data.length

    @games_data.each do |game|
      total_goals += game[:home_goals].to_i + game[:away_goals].to_i
    end

    average_goals = total_goals.to_f / total_games
    average_goals.round(2)
  end

  def average_goals_per_season
    goals_by_season = Hash.new { |hash, key| hash[key] = [] }  # {season: [goals_per_game]}

    @games_data.each do |game|
      season = game[:season]

      goals_by_season[season] << game[:home_goals].to_i + game[:away_goals].to_i
    end

    goals_by_season.transform_values! do |game_goals|
      average = game_goals.reduce(:+) / game_goals.size.to_f
      average.round(2)
    end

    goals_by_season
  end
end
