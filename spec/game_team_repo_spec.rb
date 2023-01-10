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
end