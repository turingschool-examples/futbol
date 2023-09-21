require './spec/spec_helper'

RSpec.describe Team do
  before(:each) do
    team_id = 1
    team_name = 'blah'
    @team = Team.new(team_id, team_name)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@team).to be_instance_of(Team)
    end

    it 'has attributes' do
      expect(@team.team_id).to eq(1)
      expect(@team.team_name).to eq('blah')
    end
  end
end