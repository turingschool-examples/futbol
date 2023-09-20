require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'
game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'


RSpec.describe 'StatTracker' do
  before(:each) do
  @locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end
  end

  describe '#Creates usable data' do
    it 'Game Team Data' do
      expect(@stat_tracker.game_team_data).to be_a Array
      expect(@stat_tracker.game_team_data[0]).to be_a Hash
    end

    it 'Team Data' do
      expect(@stat_tracker.team_data).to be_a Array
      expect(@stat_tracker.team_data[0]).to be_a Hash
    end
    
    it 'Game Data' do
      expect(@stat_tracker.game_data).to be_a Array
      expect(@stat_tracker.game_data[0]).to be_a Hash

    end
  end
end