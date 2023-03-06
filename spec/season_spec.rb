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

  it "exists" do
    expect(@season_1).to be_a(Season)
  end

  it "has attributes" do
    expect(@season_1.season_id).to eq("20122013")
    expect(@season_2.season_id).to eq("20132014")
    expect(@season_1.season_data).to be_a(Hash)
    expect(@season_1.season_data[:team_ids]).to eq(["3", "6", "5", "17", "16", "9", "8", "30", "26", "19", "24", "2", "15", "29", "12", "1", "27", "7", "20", "21", "22", "10", "13", "28", "18", "52", "4", "25", "23", "14"])
  end
  
  it "has the desired season data" do
    expect(@season_1.season_data[:games]).to be_a(Array)
    expect(@season_1.season_data[:games].length).to eq(806)
    expect(@season_2.season_data[:games].length).to eq(1323)
    expect(@season_1.season_data[:game_teams].length).to eq(1612)
  end
end