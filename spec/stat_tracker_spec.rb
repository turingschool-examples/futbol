# require 'rspec'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/dummy_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_a(StatTracker)
  end

  it '#best_offense' do
    expect(@stat_tracker.best_offense).to eq('FC Cincinnati')
  end

  it '#worst_offense' do
    expect(@stat_tracker.worst_offense). to eq('New England Revolution')
  end

  it '#highest_scoring_visitor' do
    expect(@stat_tracker.highest_scoring_visitor).to eq('FC Cincinnati')
  end

  it '#highest_scoring_home_team' do
    expect(@stat_tracker.highest_scoring_home_team).to eq('New York Red Bulls')
  end

  it '#lowest_scoring_visitor' do
    expect(@stat_tracker.lowest_scoring_visitor).to eq('New England Revolution')
  end

  it '#lowest_scoring_home_team' do
    expect(@stat_tracker.lowest_scoring_home_team).to eq('New York City FC')
  end

  it '#most_goals_scored' do
    expect(@stat_tracker.most_goals_scored('8')).to eq(3)
  end

  it "#fewest_goals_scored" do
    expect(@stat_tracker.fewest_goals_scored('16')).to eq(0)
  end
end
