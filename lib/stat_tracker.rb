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

#Michelle start

  def highest_total_score
    Game.highest_total_score
  end

  def lowest_total_score
    Game.lowest_total_score
  end

  def most_tackles(season_id)
    team_id = GameTeam.most_tackles(season_id)
    Team.all.find { |team| team_id == team.team_id }.team_name
  end

  def fewest_tackles(season_id)
    team_id = GameTeam.fewest_tackles(season_id)
    Team.all.find { |team| team_id == team.team_id }.team_name
  end
  #Michelle end Methods 

end
