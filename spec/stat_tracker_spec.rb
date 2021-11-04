require 'simplecov'

SimpleCov.start
SimpleCov.command_name 'Unit Tests'
require_relative '../modules/league_stats'
require_relative '../modules/game_stats'
require_relative '../modules/season_stats'
require_relative '../modules/team_stats'
require './lib/tg_stat'
require './lib/creator'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
RSpec.describe StatTracker do
  let!(:stat_tracker) do
    # game_path = './spec/fixtures/spec_games.csv'
    # team_path = './spec/fixtures/spec_teams.csv'
    # game_teams_path = './spec/fixtures/spec_game_teams.csv'

    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    StatTracker.from_csv(locations)
  end

  it "attributes" do
    expect(stattracker.game_data).to eq(CSV.read(locations[:games], headers: true, header_converters: :symbol))
    expect(stattracker.team_data).to eq(CSV.read(locations[:teams], headers: true, header_converters: :symbol))
    expect(stattracker.game_team_data).to eq(CSV.read(locations[:game_teams], headers: true, header_converters: :symbol))
  end

  it "self from csv and initialize" do
    expect(StatTracker.from_csv(locations)).to be_a(StatTracker)
  end

  describe "League Stats" do
    it "league count_of_teams" do
      expect(stattracker.count_of_teams).to eq(32)
    end

    it "best offense" do
      expect(stattracker.best_offense).to eq("FC Dallas")
    end
  end

end
