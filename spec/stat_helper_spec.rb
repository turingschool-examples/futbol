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

  context "Multi-Class Helper Methods" do
    it "#helper games_by_season" do
      expect(@stat_tracker.games_by_season.keys).to eq(@stat_tracker.games[:season].uniq)
    end
  end
end