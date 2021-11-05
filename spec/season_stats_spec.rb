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

    expected = ["20122013", "20162017", "20142015", "20152016", "20132014"]
    expect(season_obj.all_season).to eq(expected)
  end

  it 'shows an array of games for a given season' do
    season_obj = SeasonStats.new(@stat_tracker)


    expect(season_obj.array_of_games("20142015")).to be_a Array
  end

  it 'shows an array of coaches for a given season' do
    season_obj = SeasonStats.new(@stat_tracker)
    expected = []

    expect(season_obj.coaches_in_season("20122013").count).to eq(13)
  end

  it 'shows a coaches win percentage' do
    season_obj = SeasonStats.new(@stat_tracker)
    coach = "Mike Yeo"
    season = "20122013"

    expect(season_obj.coach_win_percentage(season, coach)).to eq(0.20)
  end

  it 'shows calculates win percentage' do
    season_obj = SeasonStats.new(@stat_tracker)
    results = ["WIN","WIN","WIN","WIN","LOSS"]

    expect(season_obj.win_percentage(results)).to eq(0.80)
  end

  it 'shows calculates highes win percentage per coach by season' do
    season_obj = SeasonStats.new(@stat_tracker)
    season = "20122013"

    expect(season_obj.winningest_coach(season)).to eq("Claude Julien")
  end

  it 'shows calculates lowest win percentage per coach by season' do
    season_obj = SeasonStats.new(@stat_tracker)
    season = "20122013"

    expect(season_obj.worst_coach(season)).to eq("John Tortorella")
  end

  it 'shows team_id per season' do
    season_obj = SeasonStats.new(@stat_tracker)
    season = "20122013"

    expected = ["3", "6", "5", "17", "16", "9", "8", "30", "26", "19", "24", "2", "15"]

    expect(season_obj.teams_in_season(season)).to be_a Array
    expect(season_obj.teams_in_season(season)).to eq(expected)
  end

  it 'shows an array of tackles for each team_id' do
    season_obj = SeasonStats.new(@stat_tracker)
    season = "20122013"
    team_id = "6"
    expected = 271


    expect(season_obj.team_tackles(season, team_id)).to eq(expected)
  end

  it 'shows team with most tackles in a season' do
    season_obj = SeasonStats.new(@stat_tracker)
    season = "20122013"
    expected = "Houston Dynamo"
    expect(season_obj.most_tackles(season)).to eq(expected)
  end
end
