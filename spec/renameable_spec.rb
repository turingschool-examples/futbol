require './lib/stat_tracker'
require './lib/season_statistics'
require 'simplecov'
require 'CSV'

SimpleCov.start
RSpec.describe Renameable do
  before :each do
    game_path = './data/games_test.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @season_stats = SeasonStatistics.new(@stat_tracker.games, @stat_tracker.teams, @stat_tracker.game_teams)
    @game_stats = GameStatistics.new(@stat_tracker.games, @stat_tracker.teams, @stat_tracker.game_teams)
  end

  it 'returns season_verification' do
    expect(@season_stats.season_verification(@season_stats.game_teams.first, '20132014')).to eq(false)
  end

  it 'returns generated hash' do
    expect(@season_stats.hash_generator(@season_stats.game_teams, :team_id, :shots, '20132014')).to eq({
       "16" => 44,
       "19" => 52
      })
  end

  it 'returns a hash with team ID keys and team name values' do
    expect(@season_stats.team_identifier("3")).to eq("Houston Dynamo")
  end

  it 'returns count_greater_than' do
    expect(@game_stats.count_greater_than(@game_stats.games, :home_goals, :away_goals)).to eq(49)
  end

  it 'returns count_equal_to' do
    expect(@game_stats.count_equal_to(@game_stats.games, :home_goals, :away_goals)).to eq(3)
  end
end
