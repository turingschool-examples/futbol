require_relative 'spec_helper'
require './lib/game'
require './lib/stat_tracker'

RSpec.describe Game do
  before(:each) do 
    game_path = './data_mock/games.csv'
    team_path = './data_mock/teams.csv'
    game_teams_path = './data_mock/game_teams.csv'
    
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it "is created by stat_tracker" do
    expect(@stat_tracker.games).to be_a(Array)
    expect(@stat_tracker.games).to all(be_a(Game))
  end

  it "has the expected attributes" do
    expect(@stat_tracker.games[0].game_id).to eq("2012030221")
    expect(@stat_tracker.games[0].away_team_id).to eq("3")
    expect(@stat_tracker.games[0].away_goals).to eq(2)
  end
end