require './spec/spec_helper'

RSpec.describe StatTracker do

  before(:all) do
    game_path = './data/games_fixture.csv'
    # game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_fixture.csv'
    # game_teams_path = './data/game_teams.csv'

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
    expect(@stat_tracker.highest_total_score).to eq(5)
  end

  it "finds lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq(1)
  end

  it "returns the number of teams" do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it "returns a hash of the games played and goals by each team" do
    expect(@stat_tracker.all_games_by_team.keys).to eq(["3", "6", "5", "17", "16"])
  end

  it "returns a hash of the average number of goals scored across all games for each team" do
    expected_hash =  {"3"=>1.6,
                      "6"=>2.6666666666666665,
                      "5"=>0.5,
                      "17"=>1.0,
                      "16"=>2.0}
    expect(@stat_tracker.all_average_score_by_team).to eq(expected_hash)
  end

  it "returns the name of the team with best offense" do
    expect(@stat_tracker.best_offense).to eq("FC Dallas")
  end

  it "returns the name of the team with worst offense" do
    expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
  end

  it "returns a hash of away games played by each team" do
    expect(@stat_tracker.games_by_team("away").keys).to eq(["3", "6", "5", "17"])
  end

  it "returns a hash of the average number of goals scored across all away games for each team" do
    expected_hash =  {"3"=>1.6666666666666667,
                      "6"=>3,
                      "5"=>0.5,
                      "17"=>1.0}
    expect(@stat_tracker.average_score_by_team("away")).to eq(expected_hash)
  end

  it "returns the name of the highest scoring visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it "returns the name of the lowest scoring visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("Sporting Kansas City")
  end

  it "returns a hash of home games played by each team" do
    expect(@stat_tracker.games_by_team("home").keys).to eq(["6", "3", "5", "16"])
  end

  it "returns a hash of the average number of home goals scored across all seasons for each team" do
    expected_hash =  {"16"=>2.0,
                      "3"=>1.5,
                      "5"=>0.5,
                      "6"=>2.4}
    expect(@stat_tracker.average_score_by_team("home")).to eq(expected_hash)
  end

  it "returns the name of the highest scoring home team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq("FC Dallas")
  end

  it "returns the lowest scoring home team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Sporting Kansas City")
  end

## SEASON STAT TESTS - Tested on actual dataset, NOT the fixtures

  xit "lists games by season" do

    expect(@stat_tracker.games_in_season("2012")).to be_a(Array)
  end


  xit "checks winningest coach" do

    expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
  end

  xit "checks worst coach" do

    expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
  end

  xit "checks shot accuracy of teams by season" do
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

  xit "checks most accurate team" do

    expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
    expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
  end

  xit "checks least accurate team" do

    expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
    expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  end

  xit "checks teams by total tackles within a season" do
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

  xit "checks most tackles" do

    expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  xit "checks least tackles" do

    expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
    expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
  end

end
