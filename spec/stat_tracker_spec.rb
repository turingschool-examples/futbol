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

    expect(@stat_tracker.highest_total_score).to eq 11
  end

  it "finds lowest_total_score" do

    expect(@stat_tracker.lowest_total_score).to eq 0
  end

  ## SEASON STAT TESTS

  it "checks winningest coach" do


  end

  it "checks worst coach" do


  end

  it "checks most accurate team" do


  end

  it "checks least accurate team" do


  end

  it "checks most tackles" do


  end

  it "checks least tackles" do


  end

end
