require "pry"
require "simplecov"
SimpleCov.start
require "csv"
# require './lib/stat_tracker'
require_relative "../lib/stat_tracker"

RSpec.describe StatTracker do
  it "exists" do
    stat_tracker = StatTracker.new
  end

  it "has from csv method" do
    game_path = "./data/games.csv"
    team_path = "./data/teams.csv"
    game_teams_path = "./data/game_teams.csv"

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    expect(stat_tracker.count).to eq 3
    expect(stat_tracker.keys).to eq([:games, :teams, :game_teams])
  end
end
