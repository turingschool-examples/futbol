require 'spec_helper'

RSpec.describe Team do
  before do
    @data = {
    :team_id      => 1,
    :franchise_id => 23,
    :team_name    => "Atlanta United",
    :abbreviation => "ATL",
    :stadium      => "Mercedes-Benz Stadium"
    }
    
    @team = Team.new(@data)
  end

  describe "#exists" do
    it "exists" do
      expect(@team).to be_a(Team)
    end

    it "has readable attributes" do
      expect(@team.team_id).to eq(1)
      expect(@team.franchise_id).to eq(23)
      expect(@team.team_name).to eq("Atlanta United")
      expect(@team.abbreviation).to eq("ATL")
      expect(@team.stadium).to eq("Mercedes-Benz Stadium")
    end
  end
end