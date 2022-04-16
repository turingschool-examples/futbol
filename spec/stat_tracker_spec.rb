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

  it "can create a hash with team info" do
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    expect(@stat_tracker.team_info("18")).to eq expected
  end

  it "can return most goals scored by a team" do
    expect(@stat_tracker.most_goals_scored("3")).to eq 6
  end

  it "can return fewest goals scored by a team" do
    expect(@stat_tracker.fewest_goals_scored("3")).to eq 0
  end

  it "can find a team's best season" do
    expect(@stat_tracker.best_season("6")).to eq "20132014"
  end

  it "can find a team's worst season" do
    expect(@stat_tracker.worst_season("6")).to eq "20152016"
  end

  it "can find a team's average win percentage" do
    expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
  end

  it "can find favorite opponent of a team" do
    expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
  end

  it "can find rival of a team" do
    expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
  end
end
