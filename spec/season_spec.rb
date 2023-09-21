require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'
require './lib/season'

RSpec.describe Seasons do
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
    @seasons = Seasons.new(@stat_tracker.game_team_data, @stat_tracker.team_data, @stat_tracker.game_data) 
  end

  xit "exists" do
    expect(@seasons).to be_an_instance_of Season
  end

  xit "#winningest_coach" do
    expect(@seasons.winningest_coach("20132014")).to eq "Claude Julien"
    expect(@seasons.winningest_coach("20142015")).to eq "Alain Vigneault"
  end

  xit "#worst_coach" do
    expect(@seasons.worst_coach("20132014")).to eq "Peter Laviolette"
    expect(@seasons.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
  end

  xit "#most_accurate_team" do
    expect(@seasons.most_accurate_team("20132014")).to eq "Real Salt Lake"
    expect(@seasons.most_accurate_team("20142015")).to eq "Toronto FC"
  end

  xit "#least_accurate_team" do
    expect(@seasons.least_accurate_team("20132014")).to eq "New York City FC"
    expect(@seasons.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  end

  it "#most_tackles" do
    expect(@seasons.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(@seasons.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  it "#fewest_tackles" do
    expect(@seasons.fewest_tackles("20132014")).to eq "Atlanta United"
    expect(@seasons.fewest_tackles("20142015")).to eq "Orlando City SC"
  end
end
