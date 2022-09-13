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

  it '#highest_total_score' do
    expect(@stat_tracker.highest_total_score).to eq(5)
  end

  it "#lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq(1)
  end

  it "#percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq(0.60)
  end

  it '#percentage_visitor_wins' do
    expect(@stat_tracker.percentage_visitor_wins).to eq(0.40)
  end

  it '#percent_total_ties' do
    expect(@stat_tracker.percentage_ties).to eq(0)
  end
  it '#total_games' do
    expect(@stat_tracker.total_games).to eq(10)
  end

  it '#total_home_wins' do
    expect(@stat_tracker.total_home_wins).to eq(6)
  end

  it '#total_home_losses' do
    expect(@stat_tracker.total_home_losses).to eq(4)
  end

  it '#total_ties' do
    expect(@stat_tracker.total_ties).to eq(0)
  end

  it '#total_away_losses' do
    expect(@stat_tracker.total_away_losses).to eq(@stat_tracker.total_home_wins)
  end

  it '#total_away_wins' do
    expect(@stat_tracker.total_away_wins).to eq(@stat_tracker.total_home_losses)
  end

  it '#count_of_games_by_season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({"20122013"=>10})
  end

  it '#average_goals_per_game' do
    expect(@stat_tracker.average_goals_per_game).to eq(3.7)
  end

  it '#average_goals_by_season' do
    expect(@stat_tracker.average_goals_by_season).to eq({"20122013" => 3.70})
  end
end
