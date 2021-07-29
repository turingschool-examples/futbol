require "simplecov"
require "CSV"
require "./lib/stat_tracker"
require "./lib/league"
require "./lib/team_statistics"


SimpleCov.start
RSpec.describe TeamStatistics do
  before(:each) do
    game_path = './data/games_test.csv'
    team_path = './data/teams_test.csv'
    game_teams_path = './data/game_teams_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @team_stats = TeamStatistics.new(@stat_tracker.games, @stat_tracker.teams, @stat_tracker.game_teams)
  end

  it 'exists' do
    expect(@team_stats).to be_a(TeamStatistics)
  end

  it 'can fetch team info' do
    result = {
      team_id: '3',
      franchise_id: '10',
      team_name: "Houston Dynamo",
      abbreviation: "HOU",
      link: '/api/v1/teams/3'
    }

    expect(@team_stats.team_info(3)).to eq(result)
  end
end
