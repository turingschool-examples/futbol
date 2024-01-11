require './spec/spec_helper'
require 'rspec'

describe Team do
  describe '#initialize' do
    it 'creates a Team with correct attributes' do
      team_data = {
        team_id: '1',
        franchise_id: '23',
        team_name: 'Atlanta United',
        abbreviation: 'ATL',
        stadium: 'Mercedes-Benz Stadium'
      }
      team = Team.new(team_data)

      expect(team.team_id).to eq('1')
      expect(team.franchise_id).to eq('23')
      expect(team.team_name).to eq('Atlanta United')
      expect(team.abbreviation).to eq('ATL')
      expect(team.stadium).to eq('Mercedes-Benz Stadium')
    end
  end
end
