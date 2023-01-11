require_relative "./spec_helper"

RSpec.describe GameTeamRepo do
  before(:each) do
    game_path = './spec/fixtures/games.csv'
    team_path = './spec/fixtures/teams.csv'
    game_teams_path = './spec/fixtures/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    
    @game_team = GameTeamRepo.new(locations)
  end

  describe "#Initialize" do
    it "exists" do
        expect(@game_team).to be_instance_of(GameTeamRepo)
    end
  end

  describe "#Teams best/worst offense" do
    it "average goals by team" do
      expected = {
                  "1"=>2.0, 
                  "10"=>1.0, 
                  "13"=>3.0, 
                  "16"=>3.0, 
                  "18"=>1.0, 
                  "20"=>1.0, 
                  "22"=>0.0, 
                  "24"=>1.0, 
                  "25"=>1.0, 
                  "28"=>1.5, 
                  "3"=>2.0, 
                  "4"=>1.0, 
                  "5"=>0.0, 
                  "52"=>0.5, 
                  "53"=>3.0, 
                  "6"=>1.0, 
                  "9"=>2.0
                }
      expect(@game_team.average_goals_team).to eq(expected)
    end

    it "highest_avg_goals_by_team" do
      expect(@game_team.highest_avg_goals_by_team).to eq("16")
    end

    it "lowest_avg_goals_by_team" do
      expect(@game_team.lowest_avg_goals_by_team).to eq("5")
    end

    xit "#highest_scoring_visitor" do
      expect(@game_team.highest_scoring_visitor).to eq "Columbus Crew SC"
    end

    it "#highest_scoring_home_team" do
      expect(@game_team.highest_scoring_home_team).to eq "Minnesota United FC"
    end

  end
end