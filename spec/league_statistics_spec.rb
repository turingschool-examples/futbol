require 'rspec'
require 'pry'
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

  context "League Statistics" do
    it "#count_of_teams" do
      expect(@stat_tracker.count_of_teams).to eq(32)
    end

    it "#best_offense" do
      expect(@stat_tracker.best_offense).to eq("Reign FC")
    end

    it "#worst_offense" do
      expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
    end

    it "#highest_scoring_visitor team" do
      expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
    end

    it "#highest_scoring_home_team" do
      expect(@stat_tracker.highest_scoring_home_team).to eq("Reign FC")
    end

    it "#lowest_scoring_visitor team" do
      expect(@stat_tracker.lowest_scoring_visitor).to eq("San Jose Earthquakes")
    end

    it "#lowest_scoring_home_team" do
      expect(@stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
    end
  end
end
