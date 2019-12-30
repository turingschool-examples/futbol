require "CSV"
require_relative './team'
require_relative './season'
require_relative './game'
require_relative './modules/team_searchable'
require_relative './modules/game_searchable'


class League
  include TeamSearchable
  include GameSearchable
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