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

    expect(@stat_tracker.highest_total_score).to_eq(11)
  end

  it "finds lowest_total_score" do

    expect(@stat_tracker.lowest_total_score).to_eq(0)
  end

  it "returns count_of_teams" do

    expect(@stat_tracker.count_of_teams).to_eq(32)
  end

end
