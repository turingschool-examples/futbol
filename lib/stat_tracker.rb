require_relative 'game'
require_relative 'team'
require_relative 'gameteam'

class StatTracker
  attr_reader :games, :teams, :game_teams
  
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end
  
  def self.from_csv(locations)
    games = Game.create_from_csv(locations[:games])
    teams = Team.create_from_csv(locations[:teams])
    game_teams = GameTeam.create_from_csv(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def percentage_home_wins
    Game.percentage_home_wins
  end

  def percentage_visitor_wins
    Game.percentage_visitor_wins
  end

  def percentage_ties
    Game.percentage_ties
  end

  def count_of_games_by_season
    Game.count_of_games_by_season
  end

  def average_goals_by_season
    Game.average_goals_by_season
  end

  def fewest_tackles(season_id)
    team_id = GameTeam.fewest_tackles_by_season(season_id)
    Team.find_team_name_by_id(team_id)
  end
end