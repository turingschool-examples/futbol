require 'csv'
require './lib/stat_tracker'

class Team

	attr_reader :game_id,
							:team_id,
							:hoa,
							:result,
							:settled_in,
							:head_coach,
							:goals,
							:shots,
							:tackles,
							:pim,
							:powerPlayOpportunities,
							:powerPlayGoals,
							:faceOffWinPercentage,
							:giveaways,
							:takeaways

	def initialize(data)
		@game_id                 = data[:game_id]
		@team_id                 = data[:team_id]
		@hoa                     = data[:HoA].to_i
		@result                  = data[:result]
		@settled_in              = data[:settled_in]
		@head_coach              = data[:head_coach]
		@goals                   = data[:goals]
		@shots                   = data[:shots]
		@tackles                 = data[:tackles]
		@pim                     = data[:pim]
		@power_play_opps         = data[:powerPlayOpportunities].to_i
		@powerPlayGoals          = data[:powerPlayGoals].to_i
		@face_off_win_percentage = data[:faceOffWinPercentage].to_f
		@giveaways               = data[:giveaways]
		@takeaways               = data[:takeaways]
	end
end