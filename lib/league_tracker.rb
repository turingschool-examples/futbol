require 'csv'
require './lib/game'
require './lib/team'
require './lib/team_tracker'
require './lib/game_tracker'

class LeagueTracker
  attr_reader :teams

  def initialize
    tracker = TeamTracker.new
    @teams = tracker.teams
  end

  def count_of_teams
    @teams.uniq.count 
  end



end
tracker = LeagueTracker.new
