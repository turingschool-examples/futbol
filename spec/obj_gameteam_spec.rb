require 'csv'
require 'spec_helper.rb'

RSpec.describe GameTeam do
  let(:game_team) { GameTeam.new(info) }
  let(:info) do { 
      "game_id" => "2034050625",
      "team_id" => "55",
      "HoA" => "is always bugging me",
      "settled_in" => "The Skreets",
      "head_coach" => "Dawson T The Top G",
      "goals" => "14",
      "shots" => "20",
      "tackles" => "44",
      "pim" => "11",
      "powerPlayOpportunities" => "2",
      "powerPlayGoals" => "3",
      "faceOffWinPercentage" => "67.54",
      "giveaways" => "5",
      "takeaways" => "7"
    }
  end
  
  describe "#initialize" do
    it "exists" do
      expect(game_team).to be_instance_of(GameTeam)
    end 

    it "has attributes" do
      expect(game_team.game_id).to be_a(Integer)
      expect(game_team.game_id).to eq(2034050625)

      expect(game_team.team_id).to be_a(String)
      expect(game_team.team_id).to eq("55")
      
      expect(game_team.hoa).to be_a(String)
      expect(game_team.hoa).to eq("is always bugging me")

      expect(game_team.settled_in).to be_a(String)
      expect(game_team.settled_in).to eq("The Skreets")

      expect(game_team.head_coach).to be_a(String)
      expect(game_team.head_coach).to eq("Dawson T The Top G")

      expect(game_team.goals).to be_a(Integer)
      expect(game_team.goals).to eq(14)

      expect(game_team.shots).to be_a(Integer)
      expect(game_team.shots).to eq(20)

      expect(game_team.tackles).to be_a(Integer)
      expect(game_team.tackles).to eq(44)

      expect(game_team.pim).to be_a(Integer)
      expect(game_team.pim).to eq(11)

      expect(game_team.powerplay_opportunities).to be_a(Integer)
      expect(game_team.powerplay_opportunities).to eq(2)

      expect(game_team.powerplay_goals).to be_a(Integer)
      expect(game_team.powerplay_goals).to eq(3)

      expect(game_team.faceoff_win_percentage).to be_a(Float)
      expect(game_team.faceoff_win_percentage).to eq(67.54)

      expect(game_team.giveaways).to be_a(Integer)
      expect(game_team.giveaways).to eq(5)

      expect(game_team.takeaways).to be_a(Integer)
      expect(game_team.takeaways).to eq(7)
    end
  end
end 
