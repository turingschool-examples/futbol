require './spec/spec_helper'

describe GameTeam do
  before(:each) do
    @game_team = GameTeam.new("2012030221", 3, "away", "LOSS", "OT", "John Tortorella", 2, 8, 44, 8, 3, 0, 44.8, 17, 7)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@game_team).to be_a(GameTeam)
    end

    it 'has a game id' do
      expect(@game_team.game_id).to eq("2012030221")
    end

    it 'has a team id' do
      expect(@game_team.team_id).to eq(3)
    end

    it 'tracks whether a team was home or away' do
      expect(@game_team.hoa).to eq("away")
    end

    it 'has a result' do
      expect(@game_team.result).to eq("LOSS")
    end

    it 'tracks what phase the game was settled in' do
      expect(@game_team.settled_in).to eq("OT")
    end

    it 'has a head coach' do
      expect(@game_team.head_coach).to eq("John Tortorella")
    end

    it 'has a total number of goals' do
      expect(@game_team.goals).to eq(2)
    end

    it 'has a total number of shots' do
      expect(@game_team.shots).to eq(8)
    end

    it 'has a total number of tackles' do
      expect(@game_team.tackles).to eq(44)
    end
    
    it 'has a pim' do
      expect(@game_team.pim).to eq(8)
    end

    it 'tracks power play opporturnities' do
      expect(@game_team.powerPlayOpportunities).to eq(3)
    end

    it 'tracks power play goals' do
      expect(@game_team.powerPlayGoals).to eq(0)
    end

    it 'has a face-off win percentage' do
      expect(@game_team.faceOffWinPercentage).to eq(44.8)
    end

    it 'tracks giveaways' do
      expect(@game_team.giveaways).to eq(17)
    end

    it 'tracks takeaways' do
      expect(@game_team.takeaways).to eq(7)
    end
  end
end