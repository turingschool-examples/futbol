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
      expect(team1).to be_a Team
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

      team1= GameTeam.new(game_team_data)
      
      expect(team1.team_id).to eq("1")
      expect(team1.franchise_id).to eq("2")
      expect(team1.team_name).to eq("Atlanta United")
      expect(team1.abbreviation).to eq("ATL")
      expect(team1.stadium).to eq("Mercedes-Benz")
      expect(team1.link).to eq("/api/v1/teams/1")
    end
  end
end