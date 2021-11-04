require './lib/stat_tracker'
require './lib/league_stats'
require './lib/season_stats'
require 'simplecov'
require 'csv'

RSpec.describe SeasonStats do
  before :each do
    @game_path = './data/games_test.csv'
    @team_path = './data/teams_test.csv'
    @game_teams_path = './data/game_teams_test.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      games_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'exists' do
    season_obj = SeasonStats.new(@stat_tracker)
    expect(season_obj).to be_instance_of(SeasonStats)
  end

  it 'shows all seasons in dataset' do
    season_obj = SeasonStats.new(@stat_tracker)


    expect(season_obj.all_season).to eq(["20122013","20132014","20142015"])
  end

  it 'shows an array of games for a given season' do
    season_obj = SeasonStats.new(@stat_tracker)
    expected = ["2012030122"]

    expect(season_obj.array_of_games("20132014")).to eq(expected)
  end
end
