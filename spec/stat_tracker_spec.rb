require "rspec"
require './lib/stat_tracker'
require "./lib/team"

RSpec.describe StatTracker do
  let(:stat_tracker) {StatTracker.new}

  it "1. exists" do
    expect(stat_tracker).to be_a(StatTracker)
  end

  it "2. has readable attributes" do
    expect(stat_tracker.teams_reader).to eq(nil)
    expect(stat_tracker.games_reader).to eq(nil)
    expect(stat_tracker.game_teams_reader).to eq(nil)
  end

  it "3. can parse CSV data" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games.csv',
                      games_teams: './data/game_teams.csv'

    }
    stat_tracker_teams = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker_teams.teams_reader[0][:team_id]).to eq("1")
    expect(stat_tracker_teams.teams_reader[0][:franchiseid]).to eq("23")
    expect(stat_tracker_teams.teams_reader[4][:link]).to eq("/api/v1/teams/6")
  end

  it "#average_goals_per_game" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy1.csv',
                      games_teams: './data/game_teams.csv'

    }
    stat_tracker1 = StatTracker.from_csv(dummy_filepath)

    expect(stat_tracker1.average_goals_per_game).to eq(5.00)
  end
end
