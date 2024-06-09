require 'rspec'
require_relative '../lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = 'spec/fixtures/games.csv'
    team_path = 'spec/fixtures/teams.csv'
    game_teams_path = 'spec/fixtures/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  # Game Statistics
  it "#highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 5
  end

  it "#lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 3
  end

  it "#percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.67
  end

  it "#percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.33
  end

  it "#percentage_ties" do
    expect(@stat_tracker.percentage_ties).to eq 0.0
  end

  it "#count_of_games_by_season" do
    expected = {
      "20122013" => 3
    }
    expect(@stat_tracker.count_of_games_by_season).to eq expected
  end

  it "#average_goals_per_game" do
    expect(@stat_tracker.average_goals_per_game).to eq 4.33
  end

  it "#average_goals_by_season" do
    expected = {
      "20122013" => 4.33
    }
    expect(@stat_tracker.average_goals_by_season).to eq expected
  end

  # League Statistics
  it "#count_of_teams" do
    expect(@stat_tracker.count_of_teams).to eq 2
  end

  it "#best_offense" do
    expect(@stat_tracker.best_offense).to eq "Reign FC"
  end

  it "#worst_offense" do
    expect(@stat_tracker.worst_offense).to eq "FC Cincinnati"
  end

  it "#highest_scoring_visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq "Reign FC"
  end

  it "#highest_scoring_home_team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  end

  it "#lowest_scoring_visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq "FC Cincinnati"
  end

  it "#lowest_scoring_home_team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq "FC Cincinnati"
  end

  # Season Statistics
  it "#winningest_coach" do
    expect(@stat_tracker.winningest_coach("20122013")).to eq "Claude Julien"
  end

  it "#worst_coach" do
    expect(@stat_tracker.worst_coach("20122013")). to eq "John Tortorella"
  end

  it "#most_accurate_team" do
    expect(@stat_tracker.most_accurate_team("20122013")). to eq "Reign FC"
  end

  it "#least_accurate_team" do
    expect(@stat_tracker.least_accurate_team("20122013")). to eq "FC Cincinnati"
  end

  it "#most_tackles" do
    expect(@stat_tracker.most_tackles("20122013")). to eq "FC Cincinnati"
  end

  it "#fewest_tackles" do
    expect(@stat_tracker.fewest_tackles("20122013")). to eq "Reign FC"
  end
end
