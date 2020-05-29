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


  def self.from_csv(csv_files)
    games = create_games(csv_files[:games])
    teams = create_teams(csv_files[:teams])
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

  def self.create_teams(team_file)
    teams = []
    CSV.foreach(team_file, headers: true, header_converters: :symbol) do |row|
      teams << Team.new(row)
    end
    teams
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
    games.each do |game|
        sum_total_score << game.away_goals.to_i + game.home_goals.to_i
    end
    sum_total_score.min
  end

  def percentage_home_wins
    home_wins = []
    games.each do |game|
      home_wins << game if game.home_goals > game.away_goals
    end
    percentage_of_home_wins = home_wins.count.to_f / games.count.to_f * 100
    percentage_of_home_wins.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = []
    games.each do |game|
      visitor_wins << game if game.home_goals < game.away_goals
    end
    percentage_of_visitor_wins = visitor_wins.count.to_f / games.count.to_f * 100
    percentage_of_visitor_wins.round(2)
  end

  def percentage_ties
    ties = []
    games.each do |game|
      ties << game if game.home_goals == game.away_goals
    end
    percentage_of_ties = ties.count.to_f / games.count.to_f * 100
    percentage_of_ties.round(2)
  end

  def count_of_games_by_season
    games_by_season = @games.group_by do |game|
      game.season
    end
    games_by_season.transform_values do |game|
      game.length
    end
  end

  def average_goals_per_game
    sum_total_score = 0
    games.each do |game|
        sum_total_score += game.away_goals.to_i + game.home_goals.to_i
      end
      average_goals_per_game = sum_total_score / (games.count * 2).to_f
      average_goals_per_game.round(2)
  end

  def average_goals_by_season
    games_by_season = @games.group_by do |game|
      game.season
    end
    games_by_season.transform_values do |game|
      sum_total_score = 0
      game.each do |game|
        sum_total_score += game.away_goals.to_i + game.home_goals.to_i
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
    games.map do |game|
      id_score[game.away_team_id] += game.away_goals.to_i
      id_score[game.home_team_id] += game.home_goals.to_i
    end
      id = id_score.key(id_score.values.max)
      found = teams.find do |team|
        if team.team_id == id
           return team.team_name
        end
      found
    end
  end

  def worst_offense
    id_score = Hash.new(0)
    games.map do |game|
      id_score[game.away_team_id] += game.away_goals.to_i
      id_score[game.home_team_id] += game.home_goals.to_i
    end
      id = id_score.key(id_score.values.min)
      found = teams.find do |team|
        if team.team_id == id
           return team.team_name
        end
      found
    end
  end

  # create helper methof to he;lp highest scoreing visitor method
  # create a has with the keys set to tems
  # values set to each game the team has played

  def highest_scoring_visitor
    away_team_goals = games.reduce(Hash.new(0)) do |teams, game|
      teams[game.away_team_id] += game.away_goals.to_i
      teams
    end

    away_team_goals.transform_values! do |score|
      require "pry"; binding.pry
      score = ((games.include?(teams).count).to_f / score).round(2)
    end
    away_team_goals
  end
end
