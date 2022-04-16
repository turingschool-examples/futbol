require "pry"
require "rspec"
require "csv"
require "simplecov"
SimpleCov.start
require_relative "../lib/stat_tracker"
require_relative "../lib/games"
require_relative "../lib/teams"
require_relative "../lib/game_teams"
require 'pry'

RSpec.describe StatTracker do
  before :each do
    game_path = "./data/test_games.csv"
    team_path = "./data/test_teams.csv"
    game_teams_path = "./data/test_game_teams.csv"

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_a StatTracker
  end


  it 'returns a hash for team info' do
    expected = {team_id: "4", franchiseid: "16", teamname: "Chicago Fire", abbreviation: "CHI", stadium: "SeatGeek Stadium", link: "/api/v1/teams/4"}

    expect(@stat_tracker.team_info(4)).to eq(expected)
  end
end
