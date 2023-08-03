require "spec_helper"

describe TeamsFactory do
  before(:each) do
    @factory = TeamsFactory.new
  end

  describe "#initialize" do
    it "can initialize" do
      expect(@factory).to be_a TeamsFactory
    end
  end
  
  describe "#create_teams" do
    it "can add teams" do
      expect(@factory.create_teams("./data/teams.csv")).to be_an Array
      expect(@factory.create_teams("./data/teams.csv")).to all be_a Teams

      @factory.create_teams("./data/teams.csv")

      expect(@factory.teams[0].team_id).to be 1
      expect(@factory.teams[0].franchise_id).to be 23
      expect(@factory.teams[0].team_name).to eq("Atlanta United")
      expect(@factory.teams[0].abbreviation).to eq("ATL")
      expect(@factory.teams[0].stadium).to eq("Mercedes-Benz Stadium")
    end
  end
end