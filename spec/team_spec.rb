require_relative 'spec_helper'
require './lib/team'
require './lib/stat_tracker'


RSpec.describe Team do
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

  describe '#initialize' do
    it 'exists' do
      expect(@stat_tracker.teams[0]).to be_a(Team)
      expect(@stat_tracker.teams[0].team_id).to eq("1")
    end
  end
end