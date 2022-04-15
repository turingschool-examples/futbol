require "pry"
require "rspec"
require "csv"
require "simplecov"
SimpleCov.start
require_relative "../lib/stat_tracker"
require_relative "../lib/games"

RSpec.describe Games do
  before :each do
    game_path = "./data/games.csv"
    team_path = "./data/teams.csv"
    game_teams_path = "./data/game_teams.csv"

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists and has attributes" do
    expect(@stat_tracker.games).to be_a Games
    expect(@stat_tracker.games.game_id).to eq(@stat_tracker.stats_main[:games][:game_id])
    expect(@stat_tracker.games.season).to eq(@stat_tracker.stats_main[:games][:season])
    expect(@stat_tracker.games.type).to eq(@stat_tracker.stats_main[:games][:type])
    expect(@stat_tracker.games.date_time).to eq(@stat_tracker.stats_main[:games][:date_time])
    expect(@stat_tracker.games.away_team_id).to eq(@stat_tracker.stats_main[:games][:away_team_id])
    expect(@stat_tracker.games.home_team_id).to eq(@stat_tracker.stats_main[:games][:home_team_id])
    expect(@stat_tracker.games.away_goals).to eq(@stat_tracker.stats_main[:games][:away_goals])
    expect(@stat_tracker.games.home_goals).to eq(@stat_tracker.stats_main[:games][:home_goals])
    expect(@stat_tracker.games.venue).to eq(@stat_tracker.stats_main[:games][:venue])
    expect(@stat_tracker.games.venue_link).to eq(@stat_tracker.stats_main[:games][:venue_link])
  end
end
