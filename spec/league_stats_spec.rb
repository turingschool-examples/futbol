require './lib/stat_tracker'
require './lib/league_stats'
require 'simplecov'
require 'csv'

RSpec.describe LeagueStats do
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
    league_obj = LeagueStats.new(@stat_tracker)
    expect(league_obj).to be_instance_of(LeagueStats)
  end

  it 'can store and access games data' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.game_data).to eq(@stat_tracker.games)
    expect(league_obj.team_data).to eq(@stat_tracker.teams)
    expect(league_obj.games_teams).to eq(@stat_tracker.games_teams)
  end

  it '#count_of_teams' do
     league_obj = LeagueStats.new(@stat_tracker)

     expect(league_obj.count_of_teams).to eq(20)
  end

  it '#all_teams_ids' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.all_teams_ids.length).to eq(5)
  end

  it '#average_goals_per_team' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.average_goals_per_team(3)).to eq(1.60)
  end

  it '#convert_team_id_to_name' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.convert_team_id_to_name(1)).to eq('Atlanta United')
  end

  it '#best_offense' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.best_offense).to eq('FC Dallas')
  end

  it '#worst_offense' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.worst_offense).to eq('Sporting Kansas City')
  end

  it '#average_away_goals_per_team' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.average_away_goals_per_team(9)).to eq(1.50)
  end

  it '#all_teams_ids_game_data' do
    league_obj = LeagueStats.new(@stat_tracker)

    expect(league_obj.all_teams_away_ids).to eq([3, 6, 5, 17, 16, 9, 8])
  end
end
