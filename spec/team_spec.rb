require './spec/spec_helper'
require 'rspec'

describe Team do
  describe '#initialize' do
    it 'creates a Team with correct attributes' do
      team = Team.new(
        '1',
        '23',
        'Atlanta United',
        'ATL',
        'Mercedes-Benz Stadium'
      )

      expect(team.team_id).to eq('1')
      expect(team.franchise_id).to eq('23')
      expect(team.team_name).to eq('Atlanta United')
      expect(team.abbreviation).to eq('ATL')
      expect(team.stadium).to eq('Mercedes-Benz Stadium')
    end
  end
end
