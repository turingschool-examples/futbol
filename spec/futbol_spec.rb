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
  end

  describe "#initialize" do
    it "exists" do
      expect(@futbol).to be_an_instance_of(Futbol)
      expect(@futbol.games[0]).to be_a(Game)
      expect(@futbol.game_teams[0]).to be_a(GameTeam)
      expect(@futbol.teams[0]).to be_a(Team)
    end
  end

  describe "#merge methods" do
    it 'merge_game_game_teams' do 
      @futbol.merge_game_game_teams
      expect(@futbol.games[0].home_tackles).not_to eq(nil)
    end

    it 'merge_game_game_teams' do 
      @futbol.merge_teams_to_game_game_teams
      expect(@futbol.games[0].home_team_name).not_to eq(nil)
    end
  end

  describe "#check Turing" do
    it 'check_no_exrtraneous method' do
      expect(@futbol.check_no_extraneous).to be true
    end

    it 'check no_bad_teams' do
      expect(@futbol.check_no_bad_teams).to be true
    end
  end
end