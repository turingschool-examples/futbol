require 'rspec'
require 'pry'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    tracker = StatTracker.new('file input 1', 'file input 2', 'file input 3')
    expect(tracker).to be_a(StatTracker)
  end

  it "has readable attributes" do
    tracker = StatTracker.new('file input 1', 'file input 2', 'file input 3')

    expect(tracker.games).to eq('file input 1')
    expect(tracker.teams).to eq('file input 2')
    expect(tracker.game_teams).to eq('file input 3')
  end

  it "can find the highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq(11)
  end

  it "can find the lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq(0)
  end

  it "can find the average_score_per_game" do
    # Stat_tracker has 2 lines / game. That is wy there are 10 lines and only 5.0 games.
    expect(@stat_tracker.average_score_per_game(@stat_tracker.game_teams.take(10))).to eq(22.0/5.0)
  end

  it "can list away_games_by_team_id in a hash" do
    expect(@stat_tracker.away_games_by_team_id.length).to eq(@stat_tracker.teams.length)
    expect(@stat_tracker.away_games_by_team_id).to be_a(Hash)
  end

  it "can list home_games_by_team_id in a hash" do
    expect(@stat_tracker.home_games_by_team_id.length).to eq(@stat_tracker.teams.length)
    expect(@stat_tracker.home_games_by_team_id).to be_a(Hash)
  end

  it "can find the average_scores_for_all_visitors" do
    expect(@stat_tracker.average_scores_for_all_visitors.length).to eq(@stat_tracker.teams.length)
    expect(@stat_tracker.average_scores_for_all_visitors).to be_a(Hash)
  end

  it "can find the average_scores_for_all_home_teams" do
    expect(@stat_tracker.average_scores_for_all_home_teams.length).to eq(@stat_tracker.teams.length)
    expect(@stat_tracker.average_scores_for_all_home_teams).to be_a(Hash)
  end

  it "can find the highest_scoring_visitor team" do
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it "can find the lowest_scoring_visitor team" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("San Jose Earthquakes")
  end

  it "can find the highest_scoring_home_team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq("Reign FC")
  end

  it "can find the lowest_scoring_home_team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
  end

  it "Can return team with best offense" do
    expect(@stat_tracker.best_offense).to eq("Reign FC")
  end

  it "Can return team with worst offense" do
    expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
  end

  it "Can return number of teams" do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end
end
