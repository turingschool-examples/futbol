require "spec_helper"

RSpec.describe Stats do
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

  describe "#team_name_from_id" do
    it "gets team name from team id" do
      expect(@stat_tracker.team_name_from_id("6")).to eq "FC Dallas"
    end
  end

  describe "#total_scores" do
    it "gets the total scores" do
      expect(@stat_tracker.total_scores).to eq([5, 5, 3, 5, 4, 5, 4, 4, 3, 5])
    end
  end

  describe "#percentage_results" do
    it "returns the percentage results" do
      expect(@stat_tracker.percentage_results).to eq({away_wins: 30.0, home_wins: 60.0, ties: 10.0})
    end
  end

  describe "#average_goals_per" do
    it "returns the average goals" do
      expect(@stat_tracker.average_goals_per(:game)).to eq({total: 4.3})
    end
  end

  describe "#team_avg_goals" do
    it "returns the average goals from all teams for all seasons" do
      expected = {"3" => 2.00,
                  "6" => 2.67,
                  "4" => 2.50}
      expect(@stat_tracker.team_avg_goals).to eq expected
    end
  end

  # helper
  describe "#coach_season_win_pct" do
    it "returns all coaching win pct by season" do
      expected = {"John Tortorella" => 0.0, "Claude Julien" => 100.0}
      expect(@stat_tracker.coach_season_win_pct("20122013")).to eq expected
    end
  end

  # helper
  describe "#team_accuracies" do
    it "should calculate team accuracies for a certain season" do
      expected_accuracies = {
        "6" => 0.29,
        "3" => 0.24
      }
      expect(@stat_tracker.team_accuracies("20122013")).to eq expected_accuracies
    end
  end

  # helper
  describe "#season_team_tackles" do
    it "returns all teams tackles from given season" do
      expected = {"3" => 77, "6" => 115}
      expect(@stat_tracker.season_team_tackles("20122013")).to eq expected
    end
  end

  ##== TEAM ==##
  describe "#goal_diffs" do
    it "returns all goal differentials for each game" do
      expect(@stat_tracker.goal_diffs["1"].max).to eq 2
    end
  end
  ##== TEAM ==##
end
