require "spec_helper"

RSpec.describe GameTeam do 
  describe "#intialize" do 
    it 'exists as a GameTeam class' do 
      game_team_data = {
        game_id: "2012030221",
        team_id: "3",
        hoa: "away",
        result: "LOSS",
        settled_in: "OT",
        head_coach: "John Tortorella",
        goals: "2",
        shots: "8",
        tackles: "44",
        pim: "8",
        powerplayopportunities: "3",
        powerplaygoals: "0",
        faceoffwinpercentage: "44.8",
        giveaways: "17",
        takeaways: "7"
      }

      team1= GameTeam.new(game_team_data)
      expect(team1).to be_a(GameTeam)
    end

    it 'can access attributes in GameTeam class' do
      game_team_data = {
        game_id: "2012030221",
        team_id: "3",
        hoa: "away",
        result: "LOSS",
        settled_in: "OT",
        head_coach: "John Tortorella",
        goals: "2",
        shots: "8",
        tackles: "44",
        pim: "8",
        powerplayopportunities: "3",
        powerplaygoals: "0",
        faceoffwinpercentage: "44.8",
        giveaways: "17",
        takeaways: "7"
      }

      gameteam1= GameTeam.new(game_team_data)

      expect(gameteam1.game_id).to eq("2012030221")
      expect(gameteam1.team_id).to eq("3")
      expect(gameteam1.hoa).to eq("away")
      expect(gameteam1.result).to eq("LOSS")
      expect(gameteam1.settled_in).to eq("OT")
      expect(gameteam1.head_coach).to eq("John Tortorella")
      expect(gameteam1.goals).to eq("2")
      expect(gameteam1.shots).to eq("8")
      expect(gameteam1.tackles).to eq("44")
      expect(gameteam1.pim).to eq("8")
      expect(gameteam1.powerplayopportunities).to eq("3")
      expect(gameteam1.powerplaygoals).to eq("0")
      expect(gameteam1.faceoffwinpercentage).to eq("44.8")
      expect(gameteam1.giveaways).to eq("17")
      expect(gameteam1.takeaways).to eq("7")
    end
  end
end