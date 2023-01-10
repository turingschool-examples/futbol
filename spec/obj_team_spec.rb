require 'csv'
require 'spec_helper.rb'

RSpec.describe Team do
  let(:team) { Team.new(info) }
  let(:info) do { 
      "team_id" => "55",
      "franchiseId" => "94",
      "teamName" => "Turing Coders",
      "abbreviation" => "DIA",
      "Stadium" => "Online at Home",
      "link" => "/api/BE/teams/55"
    }
  end
  
  describe "#initialize" do
    it "exists" do
    expect(team).to be_instance_of(Team)
    end 
    
    it "has attributes" do
      expect(team.team_id).to be_a(String)
      expect(team.team_id).to eq(55)

      expect(team.franchise_id).to be_a(String)
      expect(team.franchise_id).to eq(94)

      expect(team.team_name).to be_a(String)
      expect(team.team_name).to eq("Turing Coders")

      expect(team.abbreviation).to be_a(String)
      expect(team.abbreviation).to eq("DIA")

      expect(team.stadium).to be_a(String)
      expect(team.stadium).to eq("Online at Home")

      expect(team.link).to be_a(String)
      expect(team.link).to eq("/api/BE/teams/55")
    end
  end
end