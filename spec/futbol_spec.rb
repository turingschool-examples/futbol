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

  describe "#merge_game_game_teams" do
  # expand tests if there is time
    it "merges GameTeam attribute data into Game attributes in @games" do 
      @futbol.merge_game_game_teams
      expect(@futbol.games[0].home_team_goals).not_to eq(nil)
      expect(@futbol.games[0].away_team_goals).not_to eq(nil)
      expect(@futbol.games[0].home_result).not_to eq(nil)
      expect(@futbol.games[0].away_result).not_to eq(nil)
      expect(@futbol.games[0].home_shots).not_to eq(nil)
      expect(@futbol.games[0].away_shots).not_to eq(nil)
      expect(@futbol.games[0].home_head_coach).not_to eq(nil)
      expect(@futbol.games[0].away_head_coach).not_to eq(nil)
      expect(@futbol.games[0].home_tackles).not_to eq(nil)
      expect(@futbol.games[0].away_tackles).not_to eq(nil)
    end
  end

    describe 'merge_game_game_teams' do 
      it 'merges Team attribute data into Game attribuest in @games' do
      @futbol.merge_teams_to_game_game_teams
      expect(@futbol.games[0].home_team_name).not_to eq(nil)
      expect(@futbol.games[0].away_team_name).not_to eq(nil)
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