require 'CSV'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams)
    @games = games
    @teams = teams
    # @game_team = game_team
  end
end
