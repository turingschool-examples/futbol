require "spec_helper"

RSpec.describe GameTeams do
  before(:each) do 
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
        @gameteams1 = GameTeams.new({ faceoffwinpercentage: 44.8,
                                  game_id: "2012030221",
                                  giveaways: 17,
                                  goals: 2,
                                  head_coach: "John Tortorella",
                                  hoa: "away",
                                  pim: 8,
                                  powerplaygoals: 0,
                                  powerplayopportunities: 3,
                                  result: "LOSS",
                                  settled_in: "OT",
                                  shots: 8,
                                  tackles: 44,
                                  takeaways: 7,
                                  team_id: "3"})
  end
  
  describe "#initialize" do
    it "exists and has attributes" do
      expect(@gameteams1.game_id).to eq("2012030221")
      expect(@gameteams1.team_id).to eq("3")
      expect(@gameteams1.hoa).to eq("away")
      expect(@gameteams1.result).to eq("LOSS")
      expect(@gameteams1.settled_in).to eq("OT")
      expect(@gameteams1.head_coach).to eq("John Tortorella")
      expect(@gameteams1.goals).to eq(2)
      expect(@gameteams1.shots).to eq(8)
      expect(@gameteams1.tackles).to eq(44)
      expect(@gameteams1.pim).to eq(8)
      expect(@gameteams1.powerplayopp).to eq(3)
      expect(@gameteams1.powerplaygoals).to eq(0)
      expect(@gameteams1.faceoffwinperc).to eq(44.8)
      expect(@gameteams1.giveaways).to eq(17)
      expect(@gameteams1.takeaways).to eq(7)
    end
  end

  describe "#game_teams.csv" do
    it "can create an object from StatTracker" do  
      expect(@stat_tracker.game_teams[0].game_id).to eq("2012030221")
      expect(@stat_tracker.game_teams).to be_an(Array)
      expect(@stat_tracker.game_teams.sample).to be_a(GameTeams)
      expect(@stat_tracker.game_teams).to all(be_a(GameTeams))
    end
  end

  describe "#percentage home" do
    it "can calculate percentage for home wins" do
      expect(@stat_tracker.game_teams.percentage_home_wins).to eq(0.600)
    end
  end
end