require './lib/stat_tracker'
require './lib/league_stats'
require './lib/season_stats'
require './lib/data_warehouse'
require 'pry'

RSpec.describe(StatTracker) do
  before(:each) do
    game_path = "./data/games.csv"
    team_path = "./data/teams.csv"
    game_teams_path = "./data/game_teams.csv"
    locations = {games: game_path, teams: team_path, game_teams: game_teams_path}
    @stat_tracker = StatTracker.from_csv(locations)
  end

  context 'League Stats tests' do
    it 'can count teams' do
      expect(@stat_tracker.count_of_teams).to eq 32
    end

    xit 'can find best offense' do
      expect(@stat_tracker.best_offense).to eq "Reign FC"
    end

    xit 'can find worst offense' do
      expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
    end

    it 'can find highest scoring visitor' do
      expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
    end

    it 'can find highest scoring home team' do
      expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
    end

    it 'can find lowest scoring visitor' do
      expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
    end

    it 'can find lowest scoring home team' do
      expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
    end
  end
end