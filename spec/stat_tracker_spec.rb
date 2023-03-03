require './spec/spec_helper'

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
      expect(@stat_tracker.game).to be_a GameStatistics
      expect(@stat_tracker.league).to be_a LeagueStatistics
      expect(@stat_tracker.season).to be_a SeasonStatistics
    end
  end

  describe '#self.from_csv' do
    it 'returns an instance of StatTracker' do
      expect(StatTracker.from_csv(@locations)).to be_a StatTracker
      expect(@stat_tracker.game).to be_a GameStatistics
      expect(@stat_tracker.league).to be_a LeagueStatistics
      expect(@stat_tracker.season).to be_a SeasonStatistics
    end
  end
end