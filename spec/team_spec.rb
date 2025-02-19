require_relative 'spec_helper'

RSpec.describe Team do
  before do
    location = './data/teams.csv'
		@teams = Team.all_teams(location)
	end
    let(:team){@teams[0]}

  describe '#initialize' do
    it 'exists' do
      expect(team).to be_a(Team)
    end

    it 'initializes with attributes' do
      expect(team.team_id).to eq("1")
      expect(team.franchise_id).to eq("23")
      expect(team.team_name).to eq("Atlanta United")
      expect(team.abbreviation).to eq("ATL")
      expect(team.stadium).to eq("Mercedes-Benz Stadium")
      expect(team.link).to eq("/api/v1/teams/1")
    end
  end
end