require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'
require './lib/season'

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
    @season = Season.new(@stat_tracker.game_team_data, @stat_tracker.team_data)  
  end

  it "exists" do
    expect(@season).to be_an_instance_of Season
  end

  it "#winningest_coach" do
    expect(@season.winningest_coach("20132014")).to eq "Claude Julien"
    expect(@season.winningest_coach("20142015")).to eq "Alain Vigneault"
  end

  it "#worst_coach" do
    expect(@season.worst_coach("20132014")).to eq "Peter Laviolette"
    expect(@season.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
  end

  it "#most_accurate_team" do
    expect(@season.most_accurate_team("20132014")).to eq "Real Salt Lake"
    expect(@season.most_accurate_team("20142015")).to eq "Toronto FC"
  end

  it "#least_accurate_team" do
    expect(@season.least_accurate_team("20132014")).to eq "New York City FC"
    expect(@season.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  end

  it "#most_tackles" do
    expect(@season.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(@season.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  it "#fewest_tackles" do
    expect(@season.fewest_tackles("20132014")).to eq "Atlanta United"
    expect(@season.fewest_tackles("20142015")).to eq "Orlando City SC"
  end
end
