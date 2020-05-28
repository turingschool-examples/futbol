require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './team_collection'
require 'csv'
require 'pry'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

# def initialize(data)
#   @teams = CSV.read(data[:teams], headers: true, header_converters: :symbol)
#   require "pry"; binding.pry
#   @games = CSV.read(data[:games], headers: true, header_converters: :symbol)
#   @game_teams = CSV.read(data[:game_teams], headers: true, header_converters: :symbol)
# end
#
# def from_csv(data)
#   StatTracker.new(data)
# end

  def self.from_csv(csv_files)
    games = create_games(csv_files[:games])
    teams = CSV.read(csv_files[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.read(csv_files[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(games, teams, game_teams)
  end

  def self.create_games(game_file)
    games = []
    CSV.foreach(game_file, headers: true, header_converters: :symbol) do |row|
      games << Game.new(row)
    end
    games
  end

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def highest_total_score
    sum_total_score = []
    games.each do |game|
        sum_total_score << game.away_goals.to_i + game.home_goals.to_i
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

  def best_offense
    id_score = Hash.new(0)
    games.by_row.map do |data|
      id_score[data[:away_team_id]] += data[:away_goals].to_i
      id_score[data[:home_team_id]] += data[:home_goals].to_i
    end
      id = id_score.key(id_score.values.max)
      found = teams.find do |team|
        if team[:team_id] == id
           return team[:teamname]
        end
      found
    end
  end

  def worst_offense
    id_score = Hash.new(0)
    games.by_row.map do |data|
      id_score[data[:away_team_id]] += data[:away_goals].to_i
      id_score[data[:home_team_id]] += data[:home_goals].to_i
    end
      id = id_score.key(id_score.values.min)
      found = teams.find do |team|
        if team[:team_id] == id
           return team[:teamname]
        end
      found
    end
  end

  def highest_scoring_visitor
    away_team_goals = games.all.reduce(Hash.new(0)) do |teams, game|
      teams[game.away_team_id] += game.away_goals
      teams
    end
    # require "pry"; binding.pry
    # away_team_goals
  end
end
