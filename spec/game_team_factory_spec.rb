require './spec/spec_helper'

describe GameTeamFactory do
  before(:each) do
    game_team_path = './data/simple_game_teams.csv'

    @game_teams = GameTeamFactory.create_game_teams(game_team_path)
  end

  describe '#self.create_game_teams' do
    it 'returns an array of GameTeam objects' do
      expect(@game_teams).to be_a(Array)
      expect(@game_teams[0]).to be_a(GameTeam)
    end

    it 'returns a collection of GameTeam objects created with external CSV data' do
      expect(@game_teams[0].game_id).to eq("2012030221")
    end
  end
end