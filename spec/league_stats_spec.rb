require './lib/stat_tracker'
require './lib/league_stats'
require 'simplecov'
require 'csv'

RSpec.describe LeagueStats do
  before :each do
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'exists' do
    league_obj = LeagueStats.new(@stat_tracker)
    expect(league_obj).to be_instance_of(LeagueStats)
  end

  it 'can store and access games data' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.game_data).to eq(@stat_tracker.games)
    expect(league_obj.team_data).to eq(@stat_tracker.teams)
    expect(league_obj.game_teams).to eq(@stat_tracker.game_teams)
  end

  it '#all_teams_ids' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.all_teams_ids(league_obj.team_data).length).to eq(32)
  end

  it '#average_goals_per_team' do
    league_obj = LeagueStats.new(@stat_tracker)
    team = 3

    expect(league_obj.average_goals_per_team(team)).to eq(2.13)
  end

  it '#convert_team_id_to_name' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.convert_team_id_to_name(1)).to eq('Atlanta United')
  end

  it '#best_offense' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.best_offense).to eq("Reign FC")
  end

  it '#worst_offense' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.worst_offense).to eq("Utah Royals FC")
  end

  it '#average_away_goals_per_team' do
    league_obj = LeagueStats.new(@stat_tracker)
    team = 9

    expect(league_obj.average_away_goals_per_team(team)).to eq(2.01)
  end

  it '#all_teams_away_ids' do
    league_obj = LeagueStats.new(@stat_tracker)
    expected =
    [3, 6, 5, 17, 16, 9, 8, 30, 26, 19, 24, 2, 15, 20, 14, 28, 4, 21, 25, 13, 18, 10, 29, 52, 54, 1, 12, 23, 22, 7, 27, 53]

    expect(league_obj.all_teams_away_ids(league_obj.game_data)).to eq(expected)
  end

  it '#highest_scoring_visitor' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.highest_scoring_visitor).to eq('FC Dallas')
  end

  it '#lowest_scoring_visitor' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.lowest_scoring_visitor).to eq("San Jose Earthquakes")
  end

  it '#all_teams_home_ids' do
    league_obj = LeagueStats.new(@stat_tracker)
    expected =
    [6, 3, 5, 16, 17, 8, 9, 30, 19, 26, 24, 2, 15, 20, 14, 28, 4, 21, 25, 13, 18, 10, 29, 52, 54, 1, 23, 27, 7, 22, 12, 53]

    expect(league_obj.all_teams_home_ids(league_obj.game_data)).to eq(expected)
  end

  it '#average_home_goals_per_team' do
    league_obj = LeagueStats.new(@stat_tracker)
    team = 5

    expect(league_obj.average_home_goals_per_team(team)).to eq(2.39)
  end

  it '#highest_scoring_home_team' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.highest_scoring_home_team).to eq("Reign FC")
  end

  it '#lowest_scoring_home_team' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.lowest_scoring_home_team).to eq("Utah Royals FC")
  end

end
