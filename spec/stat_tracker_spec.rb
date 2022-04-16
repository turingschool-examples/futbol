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

## SEASON STAT TESTS - Tested on actual dataset, NOT the fixtures

  it "lists games by season" do

    expect(@stat_tracker.games_in_season("2012")).to be_a(Array)
  end


  it "checks winningest coach" do

    expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
  end

  it "checks worst coach" do

    expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
  end

  it "checks shot accuracy of teams by season" do
    expected = [
      ["9", 0.2638888888888889],
      ["13", 0.2641509433962264],
      ["23", 0.26655629139072845],
      ["7", 0.2682445759368836],
      ["3", 0.27007299270072993],
      ["12", 0.2733224222585925],
      ["28", 0.2739541160593792],
      ["15", 0.2819614711033275],
      ["26", 0.28327228327228327],
      ["17", 0.28780487804878047],
      ["27", 0.28907563025210087],
      ["4", 0.292259083728278],
      ["18", 0.2938053097345133],
      ["52", 0.29411764705882354],
      ["2", 0.2947019867549669],
      ["8", 0.29685157421289354],
      ["22", 0.2980769230769231],
      ["25", 0.30015082956259426],
      ["29", 0.3003194888178914],
      ["30", 0.30363036303630364],
      ["5", 0.30377906976744184],
      ["16", 0.3042362002567394],
      ["1", 0.3060428849902534],
      ["6", 0.3064066852367688],
      ["14", 0.3076923076923077],
      ["19", 0.31129032258064515],
      ["10", 0.31307550644567217],
      ["21", 0.31484502446982054],
      ["20", 0.3166023166023166],
      ["24", 0.3347763347763348]
    ]

    expect(@stat_tracker.shot_accuracy("20132014")).to eq(expected)
  end

  it "checks most accurate team" do

    expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
    expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
  end

  it "checks least accurate team" do

    expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
    expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
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
