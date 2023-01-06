require './spec/spec_helper'

describe Team do
  before do
    team_path = './data/teams.csv'
    @teams = Team.create_teams(team_path)
    @team = @teams[0]
  end

  describe '#initialize' do
		it 'exists' do
			expect(@teams).to include(Team)
		end

		it 'has attributes' do
			expect(@team.team_id).to eq("1")
		end
	end
end