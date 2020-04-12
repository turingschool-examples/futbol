require 'csv'
require_relative './game'
require_relative './team'
require_relative './game_team'

class StatTracker

  def self.from_csv(file_paths)
    game_teams_path = file_paths[:game_teams]
    games_path = file_paths[:games]
    teams_path = file_paths[:teams]

    self.new(game_teams_path, games_path, teams_path)
  end

  attr_reader :game_teams_path,
              :games_path,
              :teams_path,
              :games,
              :teams,
              :game_teams

  def initialize(game_teams_path, games_path, teams_path)
    @game_teams_path = game_teams_path
    @games_path = games_path
    @teams_path = teams_path
    create_games
    create_teams
    create_game_teams
  end

  def create_games
    @games = Game.from_csv(@games_path)
  end

  def create_teams
    @teams = Team.from_csv(@teams_path)
  end

  def create_game_teams
    @game_teams = GameTeam.from_csv(@game_teams_path)
  end

  def home_games
    GameTeam.home_games
  end

  def percentage_home_wins
    GameTeam.percentage_home_wins
  end

  def percentage_visitor_wins
    GameTeam.percentage_visitor_wins
  end

  def percentage_ties
    GameTeam.percentage_ties
  end

  def count_of_games_by_season
    Game.count_of_games_by_season
  end

  def average_goals_per_game
    Game.average_goals_per_game
  end

  def average_goals_by_season
    Game.average_goals_by_season
  end

  def highest_scoring_visitor
    team_id = Game.highest_scoring_visitor_team_id
    Team.all.find { |team| team.team_id == team_id }.team_name
  end

  def highest_scoring_home_team
    team_id = Game.highest_scoring_home_team_id
    Team.all.find { |team| team.team_id == team_id }.team_name
  end

  def lowest_scoring_visitor
    team_id = Game.lowest_scoring_visitor_team_id
    Team.all.find { |team| team.team_id == team_id }.team_name
  end

  def lowest_scoring_home_team
    team_id = Game.lowest_scoring_home_team_id
    Team.all.find { |team| team.team_id == team_id }.team_name
  end

  def best_season(team_id)
    Game.best_season(team_id)
  end

  def worst_season(team_id)
    Game.worst_season(team_id)
  end

  def best_offense
    GameTeam.best_offense
  end

  def worst_offense
    GameTeam.worst_offense
  end

  def most_accurate_team(season)
    GameTeam.most_accurate_team(season)
  end

  def least_accurate_team(season)
    GameTeam.least_accurate_team(season)
  end

  def favorite_opponent(team_id)
    team = Team.all.find do |team|
      team.team_id == GameTeam.favorite_opponent_id(team_id)
    end
    team.team_name
  end

  def rival(team_id)
    team = Team.all.find do |team|
      team.team_id == GameTeam.rival_id(team_id)
    end
    team.team_name
  end 
end
