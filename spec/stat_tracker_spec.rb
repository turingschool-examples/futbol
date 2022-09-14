require 'rspec'
require 'pry'
require './lib/stat_tracker'

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
    tracker = StatTracker.new('file input 1', 'file input 2', 'file input 3')

    expect(tracker).to be_a(StatTracker)
  end

  it "has readable attributes" do
    tracker = StatTracker.new('file input 1', 'file input 2', 'file input 3')

    expect(tracker.games).to eq('file input 1')
    expect(tracker.teams).to eq('file input 2')
    expect(tracker.game_teams).to eq('file input 3')
  end

  it "can find the highest scoring game" do
    expect(@stat_tracker.highest_total_score).to eq(11)
  end

  it "can find the lowest scoring game" do
    expect(@stat_tracker.lowest_total_score).to eq(0)
  end

  it "can find the average score per game" do
    expect(@stat_tracker.average_score_per_game(@stat_tracker.game_teams.take(10))).to eq(22.0/5.0)
  end

  xit "can list away games in a hash" do
    expect(@stat_tracker.average_score_per_game(@stat_tracker.game_teams.take(10))).to eq(22.0/5.0)
  end

  xit "can list home games in a hash" do

  end

  it "can find the highest_scoring_visitor_team" do
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it "#lowest_scoring_visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end

  xit "can find the highest_scoring_home_team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  end


end
