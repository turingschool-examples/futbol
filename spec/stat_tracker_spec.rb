require './spec/spec_helper'

describe StatTracker do
	before do
		game_path = './data/games_sample.csv'
		team_path = './data/teams.csv'
		game_teams_path = './data/game_teams_sample.csv'

		locations = {
			games: game_path,
			teams: team_path,
			game_teams: game_teams_path
		}
	end

	describe '#initialize' do
		it 'exists' do
			game_path = './data/games_sample.csv'
			team_path = './data/teams.csv'
			game_teams_path = './data/game_teams_sample.csv'

			locations = {
				games: game_path,
				teams: team_path,
				game_teams: game_teams_path
			}
			stat_tracker = StatTracker.from_csv(locations)
			expect(stat_tracker).to be_a(StatTracker)
		end
	end
	
end