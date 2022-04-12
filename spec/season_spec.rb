require 'rspec'
require './modules/season'
require './lib/stat_tracker'
require 'pry'

RSpec.describe 'Season' do
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
  end

  describe 'behavior' do
    it 'returns winningest coach' do
      expect(@stat_tracker.winningest_coach('20132014')).to eq 'Claude Julien'
      expect(@stat_tracker.winningest_coach('20142015')).to eq 'Alain Vigneault'
    end

    it 'returns worst coach' do
      expect(@stat_tracker.worst_coach('20132014')).to eq 'Peter Laviolette'
      expect(@stat_tracker.worst_coach('20142015')).to eq 'Craig MacTavish'
    end
  end
end
