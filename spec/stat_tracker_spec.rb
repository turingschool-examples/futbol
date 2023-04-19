require "./spec/spec_helper"

RSpec.describe StatTracker do 
  before(:each) do 
    @stat_tracker = StatTracker.new
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
  end

  describe "#initialize" do 
    it "can initialize with attributes" do 
      expect(@stat_tracker).to be_a(StatTracker)
      @stat_tracker = StatTracker.from_csv(@locations)
    end
  end
end