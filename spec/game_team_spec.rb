require_relative 'spec_helper'
require './lib/game_team'
require './lib/stat_tracker'

RSpec.describe GameTeam do
  before(:each) do 
    game_path = './data_mock/games.csv'
    team_path = './data_mock/teams.csv'
    game_teams_path = './data_mock/game_teams.csv'
    
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  describe 'Initialize' do
    it 'exists' do
      expect(@stat_tracker.game_teams[0]).to be_an_instance_of(GameTeam)
      expect(@stat_tracker.game_teams[0].game_id).to eq("2012030221")
    end
  end
end