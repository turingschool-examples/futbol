require './spec/spec_helper'

RSpec.describe Teams do
  before(:each) do
    team_id = 1
    @teams = Teams.new(team_id)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@teams).to be_instance_of(Teams)
    end

    it 'has attributes' do
      expect(@teams.team_id).to eq(1)
    end
  end
end