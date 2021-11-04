require './lib/stat_tracker'
require './lib/league_stats'
require './lib/season_stats'
require 'simplecov'
require 'csv'

RSpec.describe SeasonStats do
  before :each do
    @game_path = './data/games_test.csv'
    @team_path = './data/teams.csv'
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

    expected = "20122013", "20162017", "20142015", "20152016", "20132014", "20172018"
    expect(season_obj.all_season).to eq(expected)
  end

  it 'shows an array of games for a given season' do
    season_obj = SeasonStats.new(@stat_tracker)


    expect(season_obj.array_of_games("20132014")).to be_a Array
  end

  xit 'shows an array of coaches for a given season' do
    season_obj = SeasonStats.new(@stat_tracker)
    expected = []

    expect(season_obj.coaches_in_season("20132014").count).to eq(34)
  end

  it 'shows a coaches win percentage' do
    season_obj = SeasonStats.new(@stat_tracker)
    coach = "Jack Capuano"
    season = "20132014"

    expect(season_obj.coach_win_percentage(season, coach)).to eq(0.27)
  end

  it 'shows calculates win percentage' do
    season_obj = SeasonStats.new(@stat_tracker)
    results = ["WIN","WIN","WIN","WIN","LOSS"]

    expect(season_obj.win_percentage(results)).to eq(0.80)
  end


end
