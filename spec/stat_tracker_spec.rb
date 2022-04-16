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

  it "lists games by season" do


    expect(@stat_tracker.games_in_season("2012")).to be_a(Array)
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

  it "checks teams by total tackles within a season" do
    expected = [
      ["1", 1568],
      ["18", 1611],
      ["20", 1708],
      ["23", 1710],
      ["22", 1751],
      ["14", 1774],
      ["17", 1783],
      ["30", 1787],
      ["12", 1807],
      ["25", 1820],
      ["16", 1836],
      ["13", 1860],
      ["15", 1904],
      ["28", 1931],
      ["7", 1992],
      ["19", 2087],
      ["2", 2092],
      ["27", 2173],
      ["8", 2211],
      ["21", 2223],
      ["52", 2313],
      ["9", 2351],
      ["4", 2404],
      ["6", 2441],
      ["5", 2510],
      ["24", 2515],
      ["10", 2592],
      ["3", 2675],
      ["29", 2915],
      ["26", 3691]
    ]

    expect(@stat_tracker.teams_by_tackles("20132014")). to eq (expected)
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
