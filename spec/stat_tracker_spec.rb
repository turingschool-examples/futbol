require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/fake_games.csv'
    team_path = './data/fake_teams.csv'
    game_teams_path = './data/fake_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  it "can calculate the highest total game score" do
    expect(@stat_tracker.highest_total_score).to eq(5)
  end

  it "can calculate the lowest total game score" do
    expect(@stat_tracker.lowest_total_score).to eq(3)
  end

  it "can list the total number of teams" do
    expect(@stat_tracker.count_of_teams).to eq(5)
  end

  it "can name the team with the highest average score" do
    expect(@stat_tracker.best_offense).to eq("FC Dallas")
  end

  it "can name the team with the lowest average score" do
    expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
  end

  it "can name the team the highest number of tackles in a season" do
    expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
  end



end