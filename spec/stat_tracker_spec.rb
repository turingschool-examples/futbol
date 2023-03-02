require 'spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    games = './data/games.csv'
    teams = './data/teams.csv'
    game_teams = './data/game_teams.csv'
    @locations = {
      games: games,
      teams: teams,
      game_teams: game_teams
    }
    @stat_tracker = StatTracker.new(@locations)
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@stat_tracker).to be_a StatTracker
      expect(@stat_tracker.games).to eq('./data/games.csv')
      expect(@stat_tracker.teams).to eq('./data/teams.csv')
      expect(@stat_tracker.game_teams).to eq('./data/game_teams.csv')
    end
  end

  describe '#self.from_csv' do
    it 'returns an instance of StatTracker' do
      expect(StatTracker.from_csv(@locations)).to be_a StatTracker
      expect(@stat_tracker.games).to eq('./data/games.csv')
      expect(@stat_tracker.teams).to eq('./data/teams.csv')
      expect(@stat_tracker.game_teams).to eq('./data/game_teams.csv')
    end
  end
end