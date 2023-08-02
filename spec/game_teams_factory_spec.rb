require "spec_helper"

describe GameTeamsFactory do
  before(:each) do
    @factory = GameTeamsFactory.new
  end

  describe "#initialize" do
    it "can initialize" do
      expect(@factory).to be_a GameTeamsFactory
    end
  end
  
  describe "#create_game_teams" do
    it "can add game_teams" do
      expect(@factory.create_game_teams("./fixture/game_teams_fixture.csv")).to be_an Array
      expect(@factory.create_game_teams("./fixture/game_teams_fixture.csv")).to all be_a GameTeams

      @factory.create_game_teams("./fixture/game_teams_fixture.csv")

      expect(@factory.game_teams[0].game_id).to be 2012030221
      expect(@factory.game_teams[0].team_id).to be 3
      expect(@factory.game_teams[0].hoa).to eq("away")
      expect(@factory.game_teams[0].result).to eq("LOSS")
      expect(@factory.game_teams[0].settled_in).to eq("OT")
      expect(@factory.game_teams[0].head_coach).to eq("John Tortorella")
      expect(@factory.game_teams[0].goals).to be 2
      expect(@factory.game_teams[0].shots).to be 8
      expect(@factory.game_teams[0].tackles).to be 44
      expect(@factory.game_teams[0].pim).to be 8
      expect(@factory.game_teams[0].power_play_opportunities).to be 3
      expect(@factory.game_teams[0].power_play_goals).to be 0
      expect(@factory.game_teams[0].face_off_win_percentage).to be 44.8
      expect(@factory.game_teams[0].giveaways).to be 17
      expect(@factory.game_teams[0].takeaways).to be 7
    end
  end
end