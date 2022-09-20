require 'rspec'
require 'pry'
require './lib/stat_helper'
require './lib/stat_tracker'
require './lib/team_statistics'

RSpec.describe StatHelper do
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

  context "Initialize" do
    describe "#initialize" do
      it "exists" do
        tracker = StatHelper.new
        expect(tracker).to be_a(StatHelper)
      end
    end
  end

  context "Multi-Class Helper Methods" do
    it "#helper games_by_season" do
      expect(@stat_tracker.games_by_season.keys).to eq(@stat_tracker.games[:season].uniq)
    end

    it "#helper average_score_per_game" do
      # Stat_tracker has 2 lines / game. That is wy there are 10 lines and only 5.0 games.
      expect(@stat_tracker.average_score_per_game(@stat_tracker.game_teams.take(10))).to eq(22.0/5.0)
    end

    it "#helper total_games" do
      expect(@stat_tracker.total_games).to eq 7441
    end
  end
end