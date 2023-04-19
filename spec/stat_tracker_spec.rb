require "./spec/spec_helper"

RSpec.describe StatTracker do 
  before(:each) do 
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @all_csvs = StatTracker.from_csv(@locations)
    @stat_tracker = StatTrack.new(@all_csvs)
  end

  describe "#initialize" do 
    it "can initialize with attributes" do 
      require 'pry'; binding.pry
      expect(@stat_tracker).to be_a(StatTracker)
      
    end
  end
end