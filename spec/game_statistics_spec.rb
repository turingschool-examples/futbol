require './lib/stat_tracker'
require './lib/game_statistics'
require 'simplecov'
require 'CSV'

SimpleCov.start
RSpec.describe GameStatistics do
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
    @game_stats = GameStatistics.new(@stat_tracker)

  end

  it 'exists' do
    expect(@game_stats).to be_a(GameStatistics)
  end

  it 'finds highest total score' do
    expect(@game_stats.highest_total_score).to eq(5)
  end


end
