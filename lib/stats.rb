require_relative 'game_team'
require_relative 'game'
require_relative 'team'
require_relative 'calculable'

class Stats
  include Calculable

  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def team_by_id(team_id)
    @teams.find{|team| team.team_id == team_id}
  end

  def all_games_by_team(team_id)
    @game_teams.find_all{|game_team| game_team.team_id == team_id}
  end
end
