require 'spec_helper'

RSpec.describe Team do
  before(:each) do
    @details = {team_id: '1', teamname: 'Atlanta United'}
    @team = Team.new(@details)
  end
  describe '#initialize' do
    it 'exists' do
      expect(@team).to be_a(Team)
    end

    it 'has attributes' do
      expect(@team.team_id).to eq('1')
      expect(@team.team_name).to eq('Atlanta United')
    end
  end
end
