require 'csv'

class Game
	attr_reader :info
							# :season,
							# :type,
							# :date_time,
							# :away_team_id,
							# :home_team_id,
							# :away_goals,
							# :home_goals,
							# :venue,
							# :venue_link

	def initialize(data)
		@info = {
			game_id: data[:game_id].to_i,
			season: data[:season].to_i,
			type: data[:type],
			date_time: data[:date_time],
			away_team_id: data[:away_team_id].to_i,
			home_team_id: data[:home_team_id].to_i,
			away_goals: data[:away_goals].to_i,
			home_goals: data[:home_goals].to_i,
			venue: data[:venue],
			venue_link: data[:venue_link]
		}
	end

	def self.create_games(game_data)
		games = []
		CSV.foreach game_data, headers: true, header_converters: :symbol do |row|
			games << Game.new(row)
		end
		games
	end
end