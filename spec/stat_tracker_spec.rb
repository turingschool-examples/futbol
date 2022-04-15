require './spec/spec_helper'

RSpec.describe StatTracker do

  before(:all) do
    game_path = './data/games_fixture.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_fixture.csv'

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

    expect(@stat_tracker.highest_total_score).to eq 5
  end

  it "finds lowest_total_score" do

    expect(@stat_tracker.lowest_total_score).to eq 1
  end

  it "can find percentage home wins" do

    expect(@stat_tracker.percentage_home_wins).to eq 30.0
  end

  it "can find percentage visitor wins" do

    expect(@stat_tracker.percentage_visitor_wins).to eq 20.0
  end

  it "can find percentage ties" do

    expect(@stat_tracker.percentage_ties).to eq 0.0
  end

  it "can count games by season" do
    expected_hash = {"20122013" => 20}

    expect(@stat_tracker.count_of_games_by_season).to eq(expected_hash)
  end

end
