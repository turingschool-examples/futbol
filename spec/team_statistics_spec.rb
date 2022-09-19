require 'rspec'
require 'pry'
require './lib/stat_tracker'
require './lib/team_statistics'

RSpec.describe TeamStatistics do
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
    @team_tracker = TeamStatistics.from_csv(locations)
  end

  context "Initialize" do
    describe "#initialize" do
      it "exists" do
        expect(@team_tracker).to be_a(TeamStatistics)
      end
    end
  end

  context "Team Statistics" do
    it "#team_info" do
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }
    expect(@team_tracker.team_info("18")).to eq expected
    end

    it "#best_season" do
      expect(@team_tracker.best_season("6")).to eq "20132014"
    end

    it "#worst_season" do
      expect(@team_tracker.worst_season("6")).to eq "20142015"
    end

    it "#average_win_percentage" do
      expect(@team_tracker.average_win_percentage("6")).to eq 0.49
    end

    it "#most_goals_scored" do
      expect(@team_tracker.most_goals_scored("18")).to eq 7
    end

    it "#fewest_goals_scored" do
      expect(@team_tracker.fewest_goals_scored("18")).to eq 0
    end

    it "#favorite_opponent" do
      expect(@team_tracker.favorite_opponent("18")).to eq "DC United"
    end

    it "#rival" do
      expect(@team_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))  #why or LA Galaxy in the spec harness?
    end
  end
end