# require 'simplecov'
# SimpleCov.start
require './lib/team'
require './lib/game_teams'
require './modules/league_statistics'
require './lib/stat_tracker'
require 'rspec'

describe LeagueStats do
  before(:all) do
    game_path = './data/game_stub.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_team_stub.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it '#count of teams' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it '#best offense' do
    expect(@stat_tracker.best_offense).to eq('FC Dallas')
  end

  it '#worst_offense' do
    expect(@stat_tracker.worst_offense).to eq 'Sporting Kansas City'
  end

  it '#highest_scoring_visitor' do
    expect(@stat_tracker.highest_scoring_visitor).to eq 'FC Dallas'
  end

  it '#highest_scoring_home_team' do
    expect(@stat_tracker.highest_scoring_home_team).to eq 'LA Galaxy'
  end

  it '#lowest_scoring_visitor' do
    expect(@stat_tracker.lowest_scoring_visitor).to eq 'Sporting Kansas City'
  end

  it '#lowest_scoring_home_team' do
    expect(@stat_tracker.lowest_scoring_home_team).to eq 'Sporting Kansas City'
  end
end
