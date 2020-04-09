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
  #ross
  def average_goals_per_game
    Game.average_goals_per_game
  end
  #ross
  def average_goals_by_season
    Game.average_goals_by_season
  end
  #ross
  def highest_scoring_visitor
    team_id = Game.nth_scoring_team_id(:max_by, :away_team_id, :away_goals)
    Team.all.find { |team| team.team_id == team_id }.team_name
  end
  #ross
  def highest_scoring_home_team
    team_id = Game.nth_scoring_team_id(:max_by, :home_team_id, :home_goals)
    Team.all.find { |team| team.team_id == team_id }.team_name
  end
  #ross
  def lowest_scoring_visitor
    team_id = Game.nth_scoring_team_id(:min_by, :away_team_id, :away_goals)
    Team.all.find { |team| team.team_id == team_id }.team_name
  end
  #ross
  def lowest_scoring_home_team
    team_id = Game.nth_scoring_team_id(:min_by, :home_team_id, :home_goals)
    Team.all.find { |team| team.team_id == team_id }.team_name
  end



end
