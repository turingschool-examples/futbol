require 'csv'
require 'spec_helper.rb'

RSpec.describe GameStats do
  let(:game_path) { './data/games_fixture.csv' }
  let(:team_path) { './data/teams_fixture.csv' }
  let(:game_teams_path) { './data/game_teams_fixture.csv' }
  let(:locations) do 
    {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  end
  let(:stat_tracker) { StatTracker.from_csv(locations) }
  # let(:stats) { Stats.new(locations) }
  let(:league_stats) { LeagueStats.new(locations) }
  describe "League Statistics" do
    it "#count_of_teams" do
      expect(league_stats.count_of_teams).to eq(32)
    end

    it "#best_offense" do
      expect(league_stats.best_offense).to eq("Reign FC")
    end

    it "#worst_offense" do
      expect(league_stats.worst_offense).to eq("Orlando City SC")
    end

    it "#away_team_goals" do
      expect(league_stats.away_team_goals).to be_a(Hash)
    end

    it "#home_team_goals" do
      expect(league_stats.home_team_goals).to be_a(Hash)
    end

    it "#highest_scoring_visitor" do
      expect(league_stats.highest_scoring_visitor).to eq("New England Revolution")
    end

    it "#highest_scoring_home_team" do
      expect(league_stats.highest_scoring_home_team).to eq("Reign FC")
    end

    it "#lowest_scoring_visitor" do
      expect(league_stats.lowest_scoring_visitor).to eq("Orlando City SC")
    end

    it "#lowest_scoring_home_team" do
      expect(league_stats.lowest_scoring_home_team).to eq("Seattle Sounders FC")
    end
  end
end