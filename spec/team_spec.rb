require_relative 'spec_helper'

RSpec.describe Team do
  before(:all) do

    team_hash = {
      team_id: 1,
      franchiseId: 23,
      teamName: 'Atlanta United',
      abbreviation: 'ATL',
      Stadium: 'Mercedes-Benz Stadium'
    }

    @team = Team.new(team_hash)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@team).to be_a(Team)
    end

    it 'has attributes' do
      expect(@team.team_id).to eq(1)
      expect(@team.franchise_id).to eq(23)
      expect(@team.team_name).to eq('Atlanta United')
      expect(@team.abbreviation).to eq('ATL')
      expect(@team.stadium).to eq('Mercedes-Benz Stadium')
      expect(@team.games).to eq([])
    end
  end
end
