require 'csv'
require 'spec_helper.rb'

RSpec.describe GameTeam do
  let(:game_team) { GameTeam.new(info) }
  let(:info) do { 
      "game_id" => 2034050625,
      "team_id" => "55",
      "HoA" => "away",
      "settled_in" => "REG",
      "head_coach" => "Dawson Timmons",
      "goals" => 14,
      "shots" => 20,
      "tackles" => 44,
      "pim" => 11,
      "powerPlayOpportunities" => 2,
      "powerPlayGoals" => 3,
      "faceOffWinPercentage" => 67.54,
      "giveaways" => 5,
      "takeaways" => 7
    }
  end
  
  describe "#initialize" do
    it "exists" do
    expect(game_team).to be_instance_of(GameTeam)
    end 
  end
end 
