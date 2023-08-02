require "spec_helper"

describe GameTeams do
  before(:each) do
    @game_team1 = GameTeams.new(2012030221, 3, "away", "LOSS", "OT", "John Tortorella", 2, 8, 44, 8, 3, 0, 44.8, 17, 7)
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@game_team1).to be_a(GameTeams)
      expect(@game_team1.game_id).to be 2012030221
      expect(@game_team1.team_id).to be 3
      expect(@game_team1.hoa).to eq("away")
      expect(@game_team1.result).to eq("LOSS")
      expect(@game_team1.settled_in).to eq("OT")
      expect(@game_team1.head_coach).to eq("John Tortorella")
      expect(@game_team1.goals).to be 2
      expect(@game_team1.shots).to be 8
      expect(@game_team1.tackles).to be 44
      expect(@game_team1.pim).to be 8
      expect(@game_team1.powerPlayOpportunities).to be 3
      expect(@game_team1.powerPlayGoals).to be 0
      expect(@game_team1.faceOffWinPercentage).to be 44.8
      expect(@game_team1.giveaways).to be 17
      expect(@game_team1.takeaways).to be 7
    end
  end
end