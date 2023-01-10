require './spec/spec_helper'

describe Stats do
  before do
		game_path = './data/games_sample.csv'
		team_path = './data/teams.csv'
		game_teams_path = './data/game_teams_sample.csv'

		@locations = {
			games: game_path,
			teams: team_path,
			game_teams: game_teams_path
		}
	end

  let(:stat) { Stats.new(@locations) }

	describe '#initialize' do
		it 'exists' do
			expect(stat).to be_a(Stats)
		end
	end
end