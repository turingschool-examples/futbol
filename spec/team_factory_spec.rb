require './spec/spec_helper'

describe TeamFactory do
  before(:each) do
    team_path = './data/teams.csv'

    @teams = TeamFactory.create_teams(team_path)
  end

  describe '::create_teams' do
    it 'returns an array of Team objects' do
      expect(@teams).to be_a(Array)
      expect(@teams[0]).to be_a(Team)
    end

    it 'returns a collection of Team objects created with external CSV data' do
      expect(@teams[0].team_id).to eq("1")
    end
  end
end