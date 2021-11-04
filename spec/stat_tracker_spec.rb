require 'simplecov'
require './league_stats'

SimpleCov.start
SimpleCov.command_name 'Unit Tests'
require_relative '../modules/league_stats'


RSpec.describe StatTracker do
  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'
  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }
  let(:stattracker) { StatTracker.from_csv(locations) }

  it "attributes" do
    expect(stattracker.game_data).to eq(CSV.read(locations[:games], headers: true, header_converters: :symbol))
    expect(stattracker.team_data).to eq(CSV.read(locations[:teams], headers: true, header_converters: :symbol))
    expect(stattracker.game_team_data).to eq(CSV.read(locations[:game_teams], headers: true, header_converters: :symbol))
  end

  it "self from csv and initialize" do
    expect(StatTracker.from_csv(locations)).to be_a(StatTracker)
  end

  it "league count_of_teams" do
    expect(stattracker.count_of_teams).to eq(32)
  end

end
