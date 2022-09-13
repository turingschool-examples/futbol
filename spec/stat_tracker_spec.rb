require 'rspec'
require 'simplecov'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#initialize' do
    it 'exists' do
      stat_tracker = StatTracker.new
      expect(stat_tracker).to be_instance_of StatTracker
    end

    it 'has no game data to begin' do
      stat_tracker = StatTracker.new
      expect(stat_tracker.game_data).to eq nil
    end
    
    it 'has no team data to begin' do
      stat_tracker = StatTracker.new
      expect(stat_tracker.team_data).to eq nil
    end
    
    it 'has no game team data to begin' do
      stat_tracker = StatTracker.new
      expect(stat_tracker.game_teams_data).to eq nil
    end
  end
  
  describe '#self.from_csv' do
    it 'makes data accessible in class' do
      expect(@stat_tracker[0]).to be_instance_of CSV
      expect(@stat_tracker[1]).to be_instance_of CSV
      expect(@stat_tracker[2]).to be_instance_of CSV
    end
  end
end