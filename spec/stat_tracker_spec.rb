require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Unit Tests'
require_relative '../lib/stat_tracker.rb'


RSpec.describe Class do

  it "attributes" do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stattracker = StatTracker.from_csv(locations)
    expect(stattracker.game_data).to eq(CSV.read(locations[:games], headers: true, header_converters: :symbol))
    expect(stattracker.team_data).to eq(CSV.read(locations[:teams], headers: true, header_converters: :symbol))
    expect(stattracker.game_team_data).to eq(CSV.read(locations[:game_teams], headers: true, header_converters: :symbol))
  end

  it "self from csv and initialize" do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    expect(StatTracker.from_csv(locations)).to be_a(StatTracker)
  end


end
