require './lib/stat_tracker'
require 'spec_helper'
require 'rspec'


RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv',
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    
  end

  describe "initialize" do
    it "exists" do
      expect(@stat_tracker).to be_an(Array)
    end
  end

end