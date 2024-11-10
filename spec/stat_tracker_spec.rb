require_relative './spec_helper'
require './lib/stat_tracker'

RSpec.describe StatTracker do 
  before :each do
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    # Load data into variables using from_csv
    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "should exist" do
    expect(@stat_tracker).to be_a StatTracker
  end

  it "should have multiple teams" do
    #there should be at least one team
    expect(@stat_tracker.teams.count).to be > 0  
  end

  it "should have multiple games" do
    # there should be at least one game
    expect(@stat_tracker.games.count).to be > 0  
  end

  it "should have multiple game_teams" do
    #there should be at least one game_team
    expect(@stat_tracker.game_teams.count).to be > 0  
  end
end
