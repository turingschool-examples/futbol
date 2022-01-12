require_relative './findable.rb'

class Game
  include Findable
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def highest_total_score
    game_with_max = @games.max_by do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    return game_with_max[:away_goals].to_i + game_with_max[:home_goals].to_i
  end

  def lowest_total_score
    game_with_min = @games.min_by do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    return game_with_min[:away_goals].to_i + game_with_min[:home_goals].to_i
  end

  def percentage_home_wins
    home_wins = @game_teams.count do |row|
      row[:hoa] == "home" && row[:result] == "WIN"
    end
    (home_wins.to_f / @games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @game_teams.count do |row|
      row[:hoa] == "away" && row[:result] == "WIN"
    end
    (visitor_wins.to_f / @games.count.to_f).round(2)
  end

  def percentage_ties
    (tie.count.to_f / @games.count).round(2)
  end

  def tie
  @games.find_all do |game|
      game[:home_goals] == game[:away_goals]
    end
  end

  def count_of_games_by_season
    season_info = {}
    seasons = @games.map do |row|
      row[:season]
    end.flatten.uniq
    seasons.each do |season|
      season_info[season] = find_in_sheet(season, :season, @games).count
    end
    season_info
  end

  def average_goals_per_game
    total_goals = @games.sum do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.to_f/@games.count
    total_goals.round(2)
  end

  def average_goals_by_season
    goals_by_season = Hash.new(0)
    games_count = Hash.new(0)
    @games.each do |row|
      goals_by_season[row[:season]] += row[:home_goals].to_f + row[:away_goals].to_f
      games_count[row[:season]] += 1
    end
    goals_by_season.each do |season, goals|
      goals_by_season[season] = (goals/games_count[season]).round(2)
    end
    goals_by_season
  end
end
