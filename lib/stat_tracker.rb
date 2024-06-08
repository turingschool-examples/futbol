require './lib/game_teams.rb'
require './lib/games.rb'
require './lib/teams.rb'

class StatTracker
  attr_reader :games, :teams, :game_teams, :game_statistics

  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def self.from_csv(locations)
    game_teams = GameTeams.create_game_teams_data_objects(locations[:game_teams])
    games = Games.create_games_data_objects(locations[:games])
    teams = Teams.create_teams_data_objects(locations[:teams])

    StatTracker.new(game_teams, games, teams)
  end

  #Game Statistics

  def highest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.max
  end

  def lowest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.min
  end

  def percentage_home_wins
    total_games = @games.length
    home_wins = @games.count { |game| game.home_goals > game.away_goals }
    (home_wins.to_f / total_games * 100).round(2)
  end

  def percentage_visitor_wins
    total_games = @games.length
    away_wins = @games.count { |game| game.away_goals > game.home_goals }
    (away_wins.to_f / total_games * 100).round(2)
  end

  def percentage_tie_games
    total_games = @games.length
    tie_games = @games.count { |game| game.home_goals == game.away_goals }
    (tie_games.to_f / total_games * 100).round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    @games.each do |game|
        games_by_season[game.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    total_games = @games.length
    total_goals = games.sum { |game| game.home_goals + game.away_goals}
    (total_goals.to_f / total_games).round(2)
  end

  def average_goals_by_season
    total_goals_by_season = Hash.new(0)
    total_games_by_season = Hash.new(0)
    @games.each do |game|
      total_goals_by_season[game.season] += game.home_goals + game.away_goals
      total_games_by_season[game.season] += 1
    end

    average_goals_by_season = {}
    total_goals_by_season.each_key do |season|
      average_goals_by_season[season] = (total_goals_by_season[season].to_f / total_games_by_season[season]).round(2)
    end
      average_goals_by_season
  end

  #League Statistics
  
  def count_of_teams
    @teams.count
  end

  def total_goals_ever
    @game_teams.each do |goals|
      goals.sum
    end
  end

  def average_goals
    total_goals_ever.inject(0.0) {|sum, goals| sum + goals}/total_goals.size.round(2)
  end

  def best_offense
    @game_teams.max_by {|average_goals| }.first.team_name

  end
end
