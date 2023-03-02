require_relative 'spec_helper'
require './lib/season'
require './lib/stat_tracker'

  RSpec.describe Season do
    before(:each) do 
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    
    @stat_tracker = StatTracker.from_csv(@locations)
    @season_1 = Season.new("20122013", @stat_tracker.games, @stat_tracker.game_teams)
    @season_2 = Season.new("20132014", @stat_tracker.games, @stat_tracker.game_teams)
  end

  xit "exists" do
    expect(@season_1).to be_a(Season)
  end

  xit "has attributes" do
    expect(@season_1.season_id).to eq("20122013")
    expect(@season_2.season_id).to eq("20132014")
    expect(@season_1.season_data).to be_a(Hash)
  end
  
  it "has the desired season data" do
    expect(@season_1.season_data[:games]).to be_a(Array)
    expect(@season_1.season_data[:games].length).to eq(14)
    expect(@season_2.season_data[:games].length).to eq(5)
    
    expect(@season_1.season_data[:game_teams].length).to eq(10)
  end

    
end