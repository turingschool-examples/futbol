require './lib/stat_tracker'

describe StatTracker do
  before(:all) do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'

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

  it "#highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 6
  end

  it '#lowest_total_score' do
    expect(@stat_tracker.lowest_total_score).to eq 1
  end

  it '#returns the percentage of home team wins' do
    expect(@stat_tracker.percentage_home_wins).to eq 0.35
  end

  it '#returns the percentage of visitor team wins' do
    expect(@stat_tracker.percentage_vistor_wins).to eq 0.3
  end

  it '#returns the percentage of games tied' do
    expect(@stat_tracker.percentage_ties).to eq 0.35
  end
end
