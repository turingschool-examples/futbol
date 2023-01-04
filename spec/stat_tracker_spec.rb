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

  it "calculates home win %" do
  #require 'pry'; binding.pry
    expect(@stat_tracker.percentage_home_wins).to eq 0.60
  end

  it 'calculates visitor win %' do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.40
  end

  it 'calculates percent of ties' do
    expect(@stat_tracker.percentage_ties).to eq 0.0
  end

end