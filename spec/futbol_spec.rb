require 'spec_helper'

RSpec.describe Futbol do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }

    @futbol = Futbol.new(locations)
    @futbol.merge_game_game_teams
  end

  describe "#initialize" do
    it "exists" do
      expect(@futbol).to be_an_instance_of(Futbol)
      expect(@futbol.games[0]).to be_a(Game)
      expect(@futbol.game_teams[0]).to be_a(GameTeam)
      expect(@futbol.teams[0]).to be_a(Team)
      expect(@futbol.check_for_extraneous).to be true
    end
  end
end