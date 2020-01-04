require "CSV"
require_relative './team'
require_relative './season'
require_relative './game'

# A League handles all the storage for its collections.  This was a design
# idea with the thought that the seasons, games, and teams belong to a league
# and not to a stat_tracker.  The stat_tracker can inherit these collections
# for processing through it's calculation modules.

class League
	attr_reader :seasons, :teams, :game_teams

  def initialize(locations)
		@seasons = Season.from_csv(locations[:games], locations[:game_teams])
		@teams = Team.from_csv(locations[:teams])
		@game_teams = locations[:game_teams]
  end

	def self.from_csv(locations)
		self.new(locations)
	end

end