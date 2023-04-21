require "csv"
require "spec_helper"

RSpec.describe Teams do
  let(:team) {Teams.new(row)}
  let(:row) do {
    team_id: "1",
    franchiseId:  "23",
    teamName:  "Atlanta United",
    abbreviation: "ATL",
    Stadium:  "Mercedes-Benz Stadium",
    link: "Mercedes-Benz Stadium,/api/v1/teams/1"
    }
  end
  
  describe "#initialize" do
    it "exists" do 
      expect(team).to be_a(Teams)
    end
    
    it " has attributes" do
      expect(team.team_id).to eq("1")
      expect(team.team_id).to be_a(String)

      expect(team.franchise_id).to eq("23")
      expect(team.franchise_id).to be_a(String)

      expect(team.team_name).to eq("Atlanta United")
      expect(team.team_name).to be_a(String)

      expect(team.abbreviation).to eq("ATL")
      expect(team.abbreviation).to be_a(String)

      expect(team.stadium).to eq("Mercedes-Benz Stadium")
      expect(team.stadium).to be_a(String)

      expect(team.link).to eq("Mercedes-Benz Stadium,/api/v1/teams/1")
      expect(team.link).to be_a(String)
    end
  end 
end
