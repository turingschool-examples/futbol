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

  it "#most_tackles" do
    expect(@stat_tracker.most_tackles("20122013")).to eq "LA Galaxy"
    expect(@stat_tracker.most_tackles("20142015")).to eq "New York Red Bulls"
  end

  it "#fewest_tackles" do
    expect(@stat_tracker.fewest_tackles("20132014")).to eq "Chicago Red Stars"
    expect(@stat_tracker.fewest_tackles("20142015")).to eq "New York City FC"
  end

  it '#find_season' do
    expect(@stat_tracker.find_season('20122013').first).to be_a(CSV::Row)

    expect(@stat_tracker.find_season('20102011')).to eq([])
  end

  it '#total_goals' do
    expect(@stat_tracker.total_goals('20122013')).to eq({"17"=>6.0, "16"=>2.0})
  end

  it '#total_shots' do
    expect(@stat_tracker.total_shots('20122013')).to eq({"17"=>19.0, "16"=>18.0})
  end

  it '#most_accurate_team' do
    expect(@stat_tracker.most_accurate_team('20142015')).to eq('New York Red Bulls')
  end

  it '#least_accurate_team' do
    expect(@stat_tracker.least_accurate_team('20142015')).to eq('New York City FC')
  end

  it '#total_games_played_per_team(season)' do
    expect(@stat_tracker.total_games_played_per_team("20122013")).to eq({"Mike Babcock"=>3, "Joel Quenneville"=>2})
  end

  it '#total_wins_per_team(season)' do
    expect(@stat_tracker.total_wins_per_team('20122013')).to eq({"Mike Babcock"=>2, "Joel Quenneville"=>1})
  end

  it '#winningest_coach(season)' do
    expect(@stat_tracker.winningest_coach('20122013')).to eq("Mike Babcock")
  end

  it '#worst_coach(season)' do
    expect(@stat_tracker.worst_coach('20122013')).to eq("Joel Quenneville")
  end

end
