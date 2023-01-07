require './spec/spec_helper'

describe TeamStats do
	before do
		game_path = './data/games_sample.csv'
		game_teams_path = './data/game_teams_sample.csv'
		team_path = './data/teams.csv'
		@games = Game.create_games(game_path)
		@game_teams = GameTeams.create_game_teams(game_teams_path)
		@teams = Team.create_teams(team_path)
	end

	let(:stat) {TeamStats.new(@teams)}

	describe '#initialize' do
		it 'exists' do
			expect(stat).to be_a(TeamStats)
		end

		it 'has attributes' do
			expect(stat.teams).to include(Team)
		end
	end
end