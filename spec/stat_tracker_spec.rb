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

  xit "exists" do

    expect(@stat_tracker).to be_a(StatTracker)
  end

  xit "finds highest_total_score" do

    expect(@stat_tracker.highest_total_score).to eq 5
  end

  xit "finds lowest_total_score" do

    expect(@stat_tracker.lowest_total_score).to eq 1
  end

  ## SEASON STAT TESTS

  it "counts_coaches" do
    expected = {
      "John Tortorella" => 5,
      "Claude Julien" => 9,
      "Dan Bylsma" => 4,
      "Mike Babcock" => 1,
      "Joel Quenneville" => 1
    }
# require 'pry'; binding.pry

    expect(@stat_tracker.count_coaches).to eq(expected)
  end

  it "checks winningest coach" do

    expect(@stat_tracker.winningest_coach).to eq("Claude Julien")
  end

  xit "checks worst coach" do


  end

  xit "checks most accurate team" do


  end

  xit "checks least accurate team" do


  end

  xit "checks most tackles" do


  end

  xit "checks least tackles" do


  end

end
