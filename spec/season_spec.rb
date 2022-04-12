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

    it ' returns the most accurate team' do
      expect(@stat_tracker.most_accurate_team('20132014')).to eq 'Real Salt Lake'
    end

    it 'returns the least accurate team' do
      expect(@stat_tracker.least_accurate_team('20132014')).to eq 'New York City FC'
    end

    it 'returns team with most tackles' do
      expect(@stat_tracker.most_tackles('20132014')).to eq 'FC Cincinnati'
    end

    it 'returns team with least tackles' do
      expect(@stat_tracker.fewest_tackles('20132014')).to eq 'Atlanta United'
    end
  end
end
