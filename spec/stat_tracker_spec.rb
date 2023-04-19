require "./spec/spec_helper"

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
    @all_csvs = StatTracker.from_csv(locations)
    @stat_tracker = StatTracker.new(@all_csvs)
  end

  describe "#initialize" do 
    it "can initialize with attributes" do 
      expect(@stat_tracker).to be_a(StatTracker)
      expect(@stat_tracker.teams).to eq([])
      expect(@stat_tracker.games).to eq([])
      expect(@stat_tracker.all_open_csvs).to be_a(Array)
      expect(@stat_tracker.all_open_csvs[0]).to be_a(CSV)
    end
  end
end