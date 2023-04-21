require "csv"
require "spec_helper"

RSpec.describe StatHelper do
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
    @stat_helper = StatHelper.new(locations)
  end

  describe "#initialize" do 
    it "exists" do
      expect(@stat_tracker).to be_a(StatTracker)
      expect(@stat_helper).to be_a(StatHelper)
    end
  end
end