require "csv"
# require "byebug"; byebug

class StatTracker
  def self.from_csv(locations)
    games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    new(games_data, teams_data, game_teams_data)
  end
  attr_accessor :games_data, :teams_data, :game_teams_data
  def initialize(games_data, teams_data, game_teams_data)
    @games_data = games_data
    @teams_data = teams_data
    @game_teams_data = game_teams_data
  end

  def highest_total_score
    highest_score = 0

    @games_data.each do |game|
      total_score = (game[:home_goals].to_i + game[:away_goals].to_i)

      highest_score = total_score if total_score > highest_score
      highest_score.round(1)
    end

    highest_score
  end

  def lowest_total_score
    lowest_score = 100

    @games_data.each do |game|
      total_score = (game[:home_goals].to_i + game[:away_goals].to_i)

      lowest_score = total_score if total_score < lowest_score
      lowest_score.round(1)
    end
    lowest_score
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
    goals_by_season = Hash.new(0)
    games_by_season = Hash.new(0)

    @games_data.each do |game|
      season = game[:season]
      goals = game[:home_goals].to_i + game[:away_goals].to_i

      goals_by_season[season] += goals
      games_by_season[season] += 1
    end
    average_goals = {}

    goals_by_season.each do |season, total_goals|
      games_played = games_by_season[season]
      average = total_goals.to_f / games_played
      average_goals[season] = average.round(2)
    end
    average_goals
  end
end
