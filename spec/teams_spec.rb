require 'spec_helper'
RSpec.describe Team do
  before(:each) do

    stats = {
      :team_id => '1',
      :franchise_id => '23',
      :team_name => 'Atlanta United',
      :abbreviation => 'ATL',
      :link => '/api/v1/teams/1'
    }
    @team = Team.new(stats)
  end

  describe '#initialize' do 
    it 'exists' do 
      expect(@team).to be_a Team
    end

    it 'has attributes' do 
      expect(@team.team_id).to eq('1')
      expect(@team.franchise_id).to eq('23')
      expect(@team.team_name).to eq('Atlanta United')
      expect(@team.abbreviation).to eq('ATL')
      expect(@team.link).to eq('/api/v1/teams/1')
    end
  end
end

