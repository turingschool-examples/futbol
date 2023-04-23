require './lib/game_teams'

RSpec.describe GameTeams do
  before(:each) do
    @game_teams = GameTeams.new({
      game_id: "2012030221",
      team_id: "3",
      hoa: "away",
      result: "LOSS",
      head_coach: "John Tortorella",
      goals: "2",
      tackles: "44"
    })
  end

  describe 'initialize' do
    it 'exists' do
      expect(@game_teams).to be_a(GameTeams)
    end

    it 'has readable attributes' do
      expect(@game_teams.game_id).to eq("2012030221")
      expect(@game_teams.team_id).to eq("3")
      expect(@game_teams.hoa).to eq("away")
      expect(@game_teams.result).to eq("LOSS")
      expect(@game_teams.head_coach).to eq("John Tortorella")
      expect(@game_teams.goals).to eq(2)
      expect(@game_teams.tackles).to eq(44)
    end

  end
end