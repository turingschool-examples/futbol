require "csv"
require "spec_helper"

RSpec.describe GameTeams do
  let(:game_teams) {GameTeams.new(row)}
  let(:row) do {
    game_id: "2012030221",
    team_id: "3",
    HoA: "away",
    result: "LOSS",
    settled_in: "OT",
    head_coach: "John Tortorella",
    goals: 2,
    shots: 8,
    tackles: 44,
    pim: 8,
    powerPlayOpportunities: 3,
    powerPlayGoals: 0,
    faceOffWinPercentage: 44.8,
    giveaways: 17,
    takeaways: 7
    }
  end
  # before(:each) do 
  #   game_path = './data/games.csv'
  #   team_path = './data/teams.csv'
  #   game_teams_path = './data/game_teams.csv'

  #   locations = {
  #     games: game_path,
  #     teams: team_path,
  #     game_teams: game_teams_path
  #   }
  #   @stat_tracker = StatTracker.from_csv(locations)

  #   row = {
  #     game_id: "2012030221",
  #     team_id: "3",
  #     HoA: away,
  #     result: "LOSS",
  #     settled_in: "OT",
  #     head_coach: "John Tortorella",
  #     goals: "2",
  #     shots: "8",
  #     tackles: "44",
  #     pim: "8",
  #     powerPlayOpportunities: "3",
  #     powerPlayGoals: "0",
  #     faceOffWinPercentage: "44.8"
  #     giveaways: "17",
  #     takeaways: "7"
  #     }

  #   @game_teams = GameTeams.new(row)
  # end
  
  describe "#initialize" do
    it " exists" do
      expect(game_teams).to be_a(GameTeams)
    end

    it " has attributes" do
      expect(game_teams.game_id).to eq("2012030221")
      expect(game_teams.game_id).to be(String)

      expect(game_teams.team_id).to eq("3")
      expect(game_teams.team_id).to be(String)

      expect(game_teams.hoa).to eq("away")
      expect(game_teams.hoa).to eq(String)

      expect(game_teams.result).to eq("LOSS")
      expect(game_teams.result).to eq(String)

      expect(game_teams.settled_in).to eq("OT")
      expect(game_teams.settled_in).to eq(String)

      expect(game_teams.head_coach).to eq("John Tortorella")
      expect(game_teams.head_coach).to eq(String)

      expect(game_teams.goals).to eq(2)

      expect(game_teams.shots).to eq(8)

      expect(game_teams.tackles).to eq(44)

      expect(game_teams.pim).to eq(8)

      expect(game_teams.powerplayopp).to eq(3)

      expect(game_teams.powerplaygoals).to eq(0)

      expect(game_teams.faceoffwinperc).to eq(44.8)

      expect(game_teams.giveaways).to eq(17)
      
      expect(game_teams.takeaways).to eq(7)
    end
  end
end
  # describe "#game_teams.csv" do
  #   it "can create an object from StatTracker" do  
  #     expect(@stat_tracker.game_teams[0].game_id).to eq("2012030221")
  #     expect(@stat_tracker.game_teams).to be_an(Array)
  #     expect(@stat_tracker.game_teams.sample).to be_a(GameTeams)
  #     expect(@stat_tracker.game_teams).to all(be_a(GameTeams))
  #   end
  # end
