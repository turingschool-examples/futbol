require 'simplecov'
SimpleCov.start

require './lib/stat_tracker'
require './lib/futbol_csv_reader'
require './lib/league_child'
require 'csv'

RSpec.describe LeagueChild do

  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @league_child = LeagueChild.new(locations)
    @csv_reader = CSVReader.new(locations)
  end

  it 'counts total number of teams' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it "finds the highest scoring team aka best offense" do
    expect(@stat_tracker.best_offense).to eq("Reign FC")
  end

  it "finds the lowest scoring team aka worst offense" do
    expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
  end

  it "finds highest scoring visitor aka best offense when away" do
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it "finds highest scoring home team aka best offense when home" do
    expect(@stat_tracker.highest_scoring_home_team).to eq("Reign FC")
  end

  it "finds lowest scoring visitor aka worst offense when away" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("San Jose Earthquakes")
  end

  it "finds lowest scoring home team aka worst offense when home" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
  end
end
