require 'simplecov'
SimpleCov.start

require './lib/stat_tracker'
require './lib/futbol_csv_reader'
require './lib/teams_child'
require 'csv'

RSpec.describe TeamsChild do

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
    @teams_child = TeamsChild.new(locations)
    @csv_reader = CSVReader.new(locations)
  end

  it 'can give us team info' do
    expected = {:team_id=>1,
               :franchise_id=>23,
               :team_name=>"Atlanta United",
               :abbreviation=>"ATL",
               :link=>"/api/v1/teams/1"}

   expect(@stat_tracker.team_info(1)).to eq(expected)
  end

  it "gives us the best season" do
    expect(@stat_tracker.best_season("6")).to eq("20132014")
  end

  it "gives us the worst season" do
    expect(@stat_tracker.worst_season("6")).to eq("20142015")
  end

  it "gives us the average win percentage" do
    expect(@stat_tracker.average_win_percentage("6")).to eq(0.49)
  end

  it "tells us a team's favorite opponent" do
    expect(@stat_tracker.favorite_opponent("18")).to eq("DC United")
  end

  it "tells us a team's rival" do
    expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
  end

  it "gives us the most goals scored for a team " do
    expect(@stat_tracker.most_goals_scored(18)). to eq(7)
  end

  it "gives us the fewest goals scored for a team" do
    expect(@stat_tracker.fewest_goals_scored(19)).to eq(0)
  end
end
