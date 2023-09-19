require "spec_helper"

RSpec.describe StatTracker do
  before(:each) do
    game_path = "./data/games_mock.csv"
    team_path = "./data/teams.csv"
    game_teams_path = "./data/game_teams_mock.csv"

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe "#init" do
    it "exists" do
      expect(@stat_tracker).to be_a StatTracker
    end
  end

  describe "#team_name_from_id" do
    it "gets team name from team id" do
      expect(@stat_tracker.team_name_from_id("6")).to eq "FC Dallas"
    end
  end

  describe "#count_of_teams" do
    it "returns number of teams" do
      expect(@stat_tracker.count_of_teams).to eq 32
    end
  end

  describe "#team_avg_goals" do
    it "returns the average goals from all teams for all seasons" do
      expect(@stat_tracker.team_avg_goals).to eq({"3" => 2.0, "6" => 2.7})
    end
  end

  describe "#best_offense" do
    it "names team with highest average goals per game across all seasons" do
      expect(@stat_tracker.best_offense).to eq "FC Dallas"
    end
  end

  describe "#worst_offense" do
    it "names team with worst avg goals per game for all seasons" do
      expect(@stat_tracker.worst_offense).to eq "Houston Dynamo"
    end
  end

  describe "#highest_scoring_visitor" do
    it "names team with highest avg score when away across all seasons" do
      expect(@stat_tracker.highest_scoring_visitor).to eq
    end
  end
end
