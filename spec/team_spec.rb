require_relative './spec_helper'

describe Team do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @test_team = @stat_tracker.teams[0]
  end

  describe '#initialize' do
    it 'exists' do
      expect(@test_team).to be_a Team
    end

    it 'has attributes' do
      expect(@test_team.team_id).to eq("1")
      expect(@test_team.franchise_id).to eq("23")
      expect(@test_team.team_name).to eq("Atlanta United")
      expect(@test_team.abbreviation).to eq("ATL")
      expect(@test_team.stadium).to eq("Mercedes-Benz Stadium")
    end
  end
end