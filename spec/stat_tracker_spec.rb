require './spec/spec_helper'

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

    expect(@stat_tracker).to be_a(StatTracker)
  end

  it "finds highest_total_score" do

    expect(@stat_tracker.highest_total_score).to eq 11
  end

  it "finds lowest_total_score" do

    expect(@stat_tracker.lowest_total_score).to eq 0
  end

  it "can find percentage home wins" do

    expect(@stat_tracker.percentage_home_wins).to eq 0.44
  end

  it "can find percentage visitor wins" do

    expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
  end

  it "can find percentage ties" do

    expect(@stat_tracker.percentage_ties).to eq 0.20
  end

  it "can count games by season" do
    expected_hash = {
      "20122013"=>806,
      "20132014"=>1323,                         "20142015"=>1319,                           "20152016"=>1321,                         "20162017"=>1317,                           "20172018"=>1355
      }

    expect(@stat_tracker.count_of_games_by_season).to eq(expected_hash)
  end

  it "can count goals per season" do
    expected_hash = {
      "20122013"=>3322,
      "20162017"=>5565,
      "20142015"=>5461,
      "20152016"=>5499,
      "20132014"=>5547,
      "20172018"=>6019
      }

    expect(@stat_tracker.count_of_goals_by_season).to eq(expected_hash)
  end

  it "can find average goals per game" do

    expect(@stat_tracker.average_goals_per_game).to eq 4.22
  end

  it "can find average goals per game by season" do
    expected_hash = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }

    expect(@stat_tracker.average_goals_by_season).to eq(expected_hash)
  end
end
