require 'spec_helper'

RSpec.describe StatTracker do
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

  describe "initialize" do 
    it "exists" do 
      expect(@stat_tracker).to be_a(StatTracker)
    end

    it "calculates average number of goals per game" do
      expect(@stat_tracker.average_goals_per_game).to be_a(Float)
      expect(@stat_tracker.average_goals_per_game).to eq(4.22)
    end

    it "calculates average number of goals per game per season" do
      expect(@stat_tracker.average_goals_by_season).to be_a(Hash)
    end
  end
end