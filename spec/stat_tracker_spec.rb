require 'rspec'
require 'pry'
require './lib/stat_tracker'

RSpec.describe StatTracker do
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
  end
  
  it "exists" do
    tracker = StatTracker.new('file_games', 'file_teams', 'file_game_teams')

    expect(tracker).to be_a(StatTracker)
  end

  it "has readable attributes" do
    tracker = StatTracker.new('file_games', 'file_teams', 'file_game_teams')

    expect(tracker.games).to eq('file_games')
    expect(tracker.teams).to eq('file_teams')
    expect(tracker.game_teams).to eq('file_game_teams')
  end

  it "#count_of_games_by_season" do
  expected = {
    "20122013"=>806,
    "20132014"=>1323,
    "20142015"=>1319,
    "20152016"=>1321,
    "20162017"=>1317,
    "20172018"=>1355
  }
    expect(@stat_tracker.count_of_games_by_season).to eq(expected)
  end

  it "#average_goals_per_game" do
    expect(@stat_tracker.average_goals_per_game).to eq 4.22
  end

end