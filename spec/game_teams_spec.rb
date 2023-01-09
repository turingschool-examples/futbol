require './spec/spec_helper'

describe GameTeams do
  before do
    game_teams_path = './data/game_teams_sample.csv'
    @game_teams = GameTeams.create_game_teams(game_teams_path)
  end

  let(:game_team) { @game_teams[0] }

  describe '#initialize' do
    it 'exists' do
      expect(game_team).to be_a(GameTeams)
    end

    it 'has attributes' do
      expect(game_team.info[:team_id]).to eq(5)
    end
  end
end