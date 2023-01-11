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
      expect(@game_team.average_goals_team).to eq(2)
    end

    xit "highest_avg_goals_by_team" do
      expect(@game_team.highest_avg_goals_by_team).to eq(0)
    end

    xit "#worst_offense" do
      expect(@game_team.worst_offense).to eq "Sporting Kansas City"
    end
  end
end