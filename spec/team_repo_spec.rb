require_relative "./spec_helper"

RSpec.describe TeamRepo do
  before(:each) do
    game_path = './spec/fixtures/games.csv'
    team_path = './spec/fixtures/teams.csv'
    game_teams_path = './spec/fixtures/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    
    @team = TeamRepo.new(locations)
  end

  describe "#Initialize" do
    it "exists" do
        expect(@team).to be_instance_of(TeamRepo)
    end
  end

  describe "#Teams" do 
    it "#count of teams" do 
        expect(@team.count_of_teams).to eq 17
    end

    it "#get_team_name" do 
      expect(@team.get_team_name("1")).to eq "Atlanta United"
    end

    it "#team_info" do
      expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
      }
  
      expect(@team.team_info("18")).to eq expected
    end
  end
end