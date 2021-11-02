require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Unit Tests'
require_relative '../lib/stat_tracker.rb'


RSpec.describe Class do

  it "exists" do
    stattracker= StatTracker.new
    expect(stattracker).to be_a(StatTracker)
  end

  it "attributes" do
    stattracker= StatTracker.new
    expect(stattracker.games).to eq(nil)
    expect(stattracker.teams).to eq(nil)
    expect(stattracker.game_teams).to eq(nil)
  end

  it "self from csv" do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    expect(StatTracker.from_csv(locations)).to be_a(StatTracker)
    expect(StatTracker.from_csv(locations).locations).to eq({})
  end


end