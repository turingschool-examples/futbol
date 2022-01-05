require 'csv'
require './lib/game'
require './lib/team'
require './lib/team_tracker'
require './lib/game_tracker'

class LeagueTracker
  attr_reader :teams, :games

  def initialize(path)
    team_tracker = TeamTracker.new
    game_tracker = GameTracker.new(path)
    @teams = team_tracker.teams
    @games = game_tracker.games
  end

  def count_of_teams
    @teams.uniq.count
  end

  def best_offense

  end



end
