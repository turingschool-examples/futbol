require './lib/game'
require './lib/team'
require './lib/game_team'
require_relative 'csv_loadable'

class StatTracker
  include CsvLoadable

  attr_reader :games,
              :teams,
              :game_teams

  def self.from_csv(locations)
    game_teams_path = locations[:game_teams]
    games_path      = locations[:games]
    teams_path      = locations[:teams]
    StatTracker.new(game_teams_path, games_path, teams_path)
  end

  def initialize(game_teams_path, game_path, teams_path)
    @games      = load_csv_data(game_path, Game)
    @teams      = load_csv_data(teams_path, Team)
    @game_teams = load_csv_data(game_teams_path, GameTeam)
  end

  def highest_total_score #game_manager
    scores = @games.flat_map do |game|
      [game.away_goals.to_i + game.home_goals.to_i]
    end
    scores.max
  end

  def lowest_total_score #game_manager
    scores = @games.flat_map do |game|
      [game.away_goals.to_i + game.home_goals.to_i]
    end
    scores.min
  end

  def percentage_home_wins #game_team manager
    games = @game_teams.find_all do |game_team|
      game_team if game_team.hoa == "home"
    end
    wins = games.find_all do |game|
      game if game.result == "WIN"
    end
    percentage(wins, games)
  end

  def percentage_visitor_wins #game_team manager
    games = @game_teams.find_all do |game_team|
      game_team if game_team.hoa == "away"
    end
    wins = games.find_all do |game|
      game if game.result == "WIN"
    end
    percentage(wins, games)
  end

  def percentage_ties #game_team manager 
    games = @game_teams
    ties = @game_teams.find_all do |game|
      game if game.result == "TIE"
    end
    percentage(ties, games)
  end

  def percentage(array1, array2) #potential for a module later?
    percent = array1.length.to_f / array2.length.to_f
    readable_percent = (percent * 100).round(2)
  end

end
