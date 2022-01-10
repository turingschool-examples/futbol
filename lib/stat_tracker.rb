require 'csv'
require_relative './statistics'
require_relative './game_tracker'
require_relative './team_tracker'
require_relative './season_tracker'
require_relative './game_team_tracker'

class StatTracker
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_tracker = GameTracker.new(locations)
    @team_tracker = TeamTracker.new(locations)
    @season_tracker = SeasonTracker.new(locations)
    @game_team_tracker = GameTeamTracker.new(locations)
  end

  def highest_total_score
    @game_tracker.highest_total_score
  end
end
