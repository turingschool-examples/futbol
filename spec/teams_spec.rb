require "spec_helper"

describe Team do
  before(:each) do
    @team1 = Team.new(1, 23, "Atlanta United", "ATL", "Mercedes-Benz Stadium")
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@team1).to be_a(Team)
      expect(@team1.team_id).to be 1
      expect(@team1.franchise_id).to be 23
      expect(@team1.team_name).to eq("Atlanta United")
      expect(@team1.abbreviation).to eq("ATL")
      expect(@team1.stadium).to eq("Mercedes-Benz Stadium")
    end
  end
end