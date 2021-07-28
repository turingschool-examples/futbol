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
    @game_stats = GameStatistics.new(@stat_tracker.games, @stat_tracker.teams, @stat_tracker.game_teams)

  end

  it 'exists' do
    expect(@game_stats).to be_a(GameStatistics)
  end

  it 'finds highest total score' do
    expect(@game_stats.highest_total_score).to eq(5)
  end

  it 'finds lowest total score' do
    expect(@game_stats.lowest_total_score).to eq(1)
  end

  it 'counts home wins' do
    expect(@game_stats.home_team_wins).to eq(21)
  end

  it 'finds percentage of home wins' do
    expect(@game_stats.percentage_home_wins).to eq(0.72)
  end

  it 'finds visitor wins' do
    expect(@game_stats.visitor_team_wins).to eq(7)
  end

  it 'finds percentage of visitor wins' do
    expect(@game_stats.percentage_visitor_wins).to eq(0.24)
  end

  it 'finds number of ties' do
    expect(@game_stats.ties).to eq(1)
  end


  it 'finds percentage of ties' do
    expect(@game_stats.percentage_ties).to eq(0.03)
  end

  it 'finds the count of games by season' do
    expect(@game_stats.count_of_games_by_season).to eq({ '20122013' => 29 })
  end

  it 'finds average goals by game' do
    expect(@game_stats.average_goals_per_game).to eq(3.69)
  end

  it 'finds total goals by season' do
    expect(@game_stats.total_goals_by_season).to eq({ '20122013' =>107 })
  end

  it 'finds average_goals_per_game' do
    expect(@game_stats.average_goals_by_season).to eq({ '20122013' => 3.69 })
  end
end
