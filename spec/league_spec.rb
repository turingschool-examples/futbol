require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'
require './lib/league'

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
    @league = League.new(@stat_tracker.game_data, @stat_tracker.team_data, @stat_tracker.game_team_data)
  end

  
  
  it "exists" do
    expect(@league).to be_an_instance_of League
  end

  it "#count_of_teams" do
    expect(@league.count_of_teams).to eq 32
  end

  xit "#best_offense" do
    expect(@league.best_offense).to eq "Reign FC"
  end

  xit "#worst_offense" do
    expect(@league.worst_offense).to eq "Utah Royals FC"
  end

  it "#highest_scoring_visitor" do
    expect(@league.highest_scoring_visitor).to eq "FC Dallas"
  end

  xit "#highest_scoring_home_team" do
    expect(@league.highest_scoring_home_team).to eq "Reign FC"
  end

  xit "#lowest_scoring_visitor" do
    expect(@league.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end

  xit "#lowest_scoring_home_team" do
    expect(@league.lowest_scoring_home_team).to eq "Utah Royals FC"
  end
end