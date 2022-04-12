require './lib/game'
require './lib/game_teams'
require './modules/game_statistics'
require './lib/stat_tracker'
require 'rspec'

describe GameStats do
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

  it "#lowest_total_score" do
      expect(@stat_tracker.lowest_total_score).to eq 0
    end

  it "#percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.44
  end

  it "sees the home win percentage" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.44
  end

  it "#percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
  end

  it "#percentage_ties" do
      expect(@stat_tracker.percentage_ties).to eq 0.20
  end

end
