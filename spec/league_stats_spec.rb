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

  it '#count_of_teams' do
     league_obj = LeagueStats.new(@stat_tracker)

     expect(league_obj.count_of_teams).to eq(20)
  end
end
