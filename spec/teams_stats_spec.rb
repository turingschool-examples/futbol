require './spec/spec_helper'

describe TeamStats do
	before do
		team_path = './data/teams.csv'
		@teams = Team.create_teams(team_path)
	end

	let(:stat) {TeamStats.new(@teams)}

	describe '#initialize' do
		it 'exists' do
			expect(stat).to be_a(TeamStats)
		end

		it 'has attributes' do
			expect(stat.teams)
	end
end