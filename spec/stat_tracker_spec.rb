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
    expect(@stat_tracker.highest_total_score).to eq(5)
  end

  it "finds lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq(1)
  end

  it "returns the number of teams" do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it "returns a hash of the games played and goals by each team" do
    expect(@stat_tracker.games_by_team.keys).to eq(["3", "6", "5", "17", "16"])
  end

  it "returns a hash of the average number of goals scored across all games for each team" do
    expected_hash =  {"3"=>1.6,
                      "6"=>2.6666666666666665,
                      "5"=>0.5,
                      "17"=>1.0,
                      "16"=>2.0}
    expect(@stat_tracker.average_score_by_team).to eq(expected_hash)
  end

  it "returns the name of the team with best offense" do
    expect(@stat_tracker.best_offense).to eq("FC Dallas")
  end

  it "returns the name of the team with worst offense" do
    expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
  end

  it "returns a hash of away games played by each team" do
    expect(@stat_tracker.away_games_by_team.keys).to eq(["3", "6", "5", "17"])
  end

  it "returns a hash of the average number of goals scored across all away games for each team" do
    expected_hash =  {"3"=>1.6666666666666667,
                      "6"=>3,
                      "5"=>0.5,
                      "17"=>1.0}
    expect(@stat_tracker.average_away_score_by_team).to eq(expected_hash)
  end

  it "returns the name of the highest scoring visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it "returns the name of the lowest scoring visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("Sporting Kansas City")
  end

end
