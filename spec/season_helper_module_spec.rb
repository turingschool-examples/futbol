require 'spec_helper'

RSpec.describe Seasonable do
  mock_games_data = './data/mock_games.csv' 
  team_data = './data/teams.csv' 
  mock_game_teams_data = './data/mock_game_teams.csv' 

  let!(:mock_locations) {{games: mock_games_data, teams: team_data, game_teams: mock_game_teams_data}}

  let!(:stat_tracker) { StatTracker.from_csv(mock_locations) }

  it '#games_by_season' do
    expect(stat_tracker.games_by_season("20122013")).to include("2012030132")
    expect(stat_tracker.games_by_season("20122013")).to include("2012030323")
    expect(stat_tracker.games_by_season("20142015")).to include("2014030315")
    expect(stat_tracker.games_by_season("20152016")).to include("2015020975")
  end

  it '#coaches_by_season' do
    expect(stat_tracker.coaches_by_season("20122013")).to include(:"Dan Bylsma")
    expect(stat_tracker.coaches_by_season("20152016")).to include(:"Paul Maurice")
  end
end

