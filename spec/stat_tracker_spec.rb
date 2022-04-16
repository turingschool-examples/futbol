require './spec/spec_helper'

RSpec.describe StatTracker do

  before(:all) do
    game_path = './data/games.csv'
    # game_path = './data/games_fixture.csv'
    team_path = './data/teams.csv'
    # game_teams_path = './data/game_teams_fixture.csv'
    game_teams_path = './data/game_teams.csv'

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

  xit "lists games by season" do
# require 'pry'; binding.pry

    expect(@stat_tracker.games_in_season("2012")).to eq([])
  end


  it "checks winningest coach" do

    expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
  end

  it "checks worst coach" do

    expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
  end

  xit "checks most accurate team" do


  end

  xit "checks least accurate team" do


  end

  it "#teams_by_tackles" do

    expect(@stat_tracker.teams_by_tackles("20132014")). to eq ([])
  end

  it "checks most tackles" do

    expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  it "checks least tackles" do

    expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
    expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
  end

end
