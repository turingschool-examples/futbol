require 'CSV'
require 'pry'

require_relative './game_teams'
require_relative './team_manager'

class GameTeamsManager
  attr_reader :game_teams_objects, :game_teams_path, :teams, :games

  def initialize(game_teams_path)
    @game_teams_path = './data/game_teams.csv'
    @game_teams_objects = CSV.read(game_teams_path, headers: true, header_converters: :symbol).map {|row| GameTeams.new(row)}
    @teams = TeamManager.new('./data/teams.csv').team_objects
    @games = GameManager.new('./data/games.csv').game_objects
  end

  def games_by_team_id(team_id, hoa = nil)
    @game_teams_objects.find_all do |game|
      if hoa == nil
        game.team_id == team_id
      else
        game.hoa == hoa && game.team_id == team_id
      end
    end
  end

  def total_goals_by_team(team_id, hoa = nil)
    games_by_team_id(team_id, hoa).sum do |game|
      game.goals
    end
  end

  def average_goals_per_game_by_id(team_id, hoa = nil)
    average = total_goals_by_team(team_id, hoa) / games_by_team_id(team_id, hoa).count.to_f
    average.round(2)
  end

  def best_offense
    teams.max_by { |team| average_goals_per_game_by_id(team.team_id) }.teamname
  end

  def worst_offense
    teams.min_by { |team| average_goals_per_game_by_id(team.team_id) }.teamname
  end

  def wins_by_team_id(team_id, hoa = nil)
    games_by_team_id(team_id, hoa).find_all do |game|
        game.result == "WIN"
    end
  end

  def average_win_percentage(team_id, hoa = nil)
    win_percent = wins_by_team_id(team_id).count
    other_percent = games_by_team_id(team_id,).count
    total = win_percent.to_f/other_percent
    total.round(2)
  end

  def highest_scoring_visitor
    teams.max_by { |team| average_goals_per_game_by_id(team.team_id, "away") }.teamname
  end

  def highest_scoring_home_team
    teams.max_by { |team| average_goals_per_game_by_id(team.team_id, "home") }.teamname
  end

  def lowest_scoring_visitor
    teams.min_by { |team| average_goals_per_game_by_id(team.team_id, "away") }.teamname
  end

  def lowest_scoring_home_team
    teams.min_by { |team| average_goals_per_game_by_id(team.team_id, "home") }.teamname
  end

  def total_tackles_by_team_id(team_id, season = nil)
    games_by_team_id(team_id).sum do |game|
      if game_is_in_season(season, game.game_id)
        game.tackles
      else
        0
      end
    end
  end

  def game_is_in_season(season, game_id)
    @games.any? do |game|
      game.season == season && game.game_id == game_id
    end
  end

  def most_tackles(season)
    most_tackles = @teams.max_by { |team| total_tackles_by_team_id(team.team_id,season) }
    most_tackles.teamname
  end

  def fewest_tackles(season)
    least_tackles = @teams.min_by { |team| total_tackles_by_team_id(team.team_id,season) }
    least_tackles.teamname
  end

  def most_goals_scored(team_id)
    games_by_team_id = @game_teams_objects.find_all { |game| game.team_id == team_id.to_i }
    most = games_by_team_id.max_by do |game|
      game.goals
    end
    most.goals
  end

  def fewest_goals_scored(team_id)
    games_by_team_id = @game_teams_objects.find_all { |game| game.team_id == team_id.to_i  }
    fewest = games_by_team_id.min_by do |game|
      game.goals
    end
    fewest.goals
  end
end
