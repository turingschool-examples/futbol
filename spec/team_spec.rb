require 'spec_helper'

RSpec.describe Team do
  describe '#initialize' do
    it 'exists' do
      details = {team_id: '1', teamname: 'Atlanta United'}
      team = Team.new(details)
      expect(team).to be_a(Team)
      expect(team.team_id).to eq('1')
      expect(team.team_name).to eq('Atlanta United')
    end
  end
end
