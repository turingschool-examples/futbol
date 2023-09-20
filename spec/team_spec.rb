require './spec/spec_helper'

RSpec.describe Team do
  before(:each) do
    team_id = 1
    @team = Team.new(team_id)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@team).to be_instance_of(Team)
    end

    it 'has attributes' do
      expect(@team.team_id).to eq(1)
    end
  end
end