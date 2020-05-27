require_relative './game'
require_relative './team'
require_relative './game_teams'
require 'csv'
require 'pry'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def self.from_csv(csv_files)
    games = CSV.read(csv_files[:games], headers: true, header_converters: :symbol)
    teams = CSV.read(csv_files[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.read(csv_files[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(games, teams, game_teams)
  end

  def initialize(game_path, team_path, game_teams_path)
    @games = game_path
    @teams = team_path
    @game_teams = game_teams_path
  end

  def highest_total_score
    sum_total_score = []
    games.by_row.each do |data|
        sum_total_score << data[:away_goals].to_i + data[:home_goals].to_i
    end
    sum_total_score.max
  end

  def lowest_total_score
    sum_total_score = []
    games.by_row.each do |data|
        sum_total_score << data[:away_goals].to_i + data[:home_goals].to_i
    end
    sum_total_score.min
  end

  def percentage_home_wins
    home_wins = []
    games.by_row.each do |data|
      home_wins << data if data[:home_goals] > data[:away_goals]
    end
    percentage_of_home_wins = home_wins.count.to_f / games.count.to_f * 100
    percentage_of_home_wins.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = []
    games.by_row.each do |data|
      visitor_wins << data if data[:home_goals] < data[:away_goals]
    end
    percentage_of_visitor_wins = visitor_wins.count.to_f / games.count.to_f * 100
    percentage_of_visitor_wins.round(2)
  end

  def percentage_ties
    ties = []
    games.by_row.each do |data|
      ties << data if data[:home_goals] == data[:away_goals]
    end
    percentage_of_ties = ties.count.to_f / games.count.to_f * 100
    percentage_of_ties.round(2)
  end

  def count_of_games_by_season
    games_by_season = @games.group_by do |game|
      game[:season]
    end
    games_by_season.transform_values do |game|
      game.length
    end
  end

  def average_goals_per_game
    sum_total_score = 0
    games.by_row.each do |data|
        sum_total_score += data[:away_goals].to_i + data[:home_goals].to_i
      end
      average_goals_per_game = sum_total_score / (games.count * 2).to_f
      average_goals_per_game.round(2)
  end

  def average_goals_by_season
    games_by_season = @games.group_by do |game|
      game[:season]
    end
    games_by_season.transform_values do |game|
      sum_total_score = 0
      game.each do |single|
        sum_total_score += single[:away_goals].to_i + single[:home_goals].to_i
      end
      average_goals_per_season = sum_total_score / (game.count * 2).to_f
      average_goals_per_season.round(2)
    end
  end

  ## start of league statistics

  def count_of_teams
    teams.count
  end

  
end
