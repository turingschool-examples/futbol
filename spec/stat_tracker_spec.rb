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

  ###=== GAME QUERIES ===###

  describe "#highest_total_score" do
    it "returns the highest total score" do
      expect(@stat_tracker.highest_total_score).to eq(5)
    end
  end

  describe "#lowest_total_score" do
    it "returns the lowest total score" do
      expect(@stat_tracker.lowest_total_score).to eq(3)
    end
  end

  describe "#percentage_home_wins" do
    it "returns the percentage of home games a team has won" do
      expect(@stat_tracker.percentage_home_wins).to eq(60.00)
    end
  end

  describe "#percentage_visitor_wins" do
    it "returns the percentage of home games a team has won" do
      expect(@stat_tracker.percentage_visitor_wins).to eq(30.00)
    end
  end

  describe "#percentage_ties" do
    it "returns the percentage of games ending in a tie" do
      expect(@stat_tracker.percentage_ties).to eq(10.00)
    end
  end

  describe "#count_of_games_by_season" do
    it "returns the number of games in a season" do
      expected_outcome = {
        "20122013" => 8,
        "20132014" => 2
      }
      expect(@stat_tracker.count_of_games_by_season).to eq(expected_outcome)
    end
  end

  describe "average_goals_per_game" do
    it "should return the average goals per game" do
      expect(@stat_tracker.average_goals_per_game).to eq(4.30)
    end
  end

  describe "average_goals_per_season" do
    it "should return the average points per season" do
      expected_outcome = {
        "20122013" => 4.38,
        "20132014" => 4.0
      }
      expect(@stat_tracker.average_goals_per_season).to eq(expected_outcome)
    end
  end

  ###=== GAME QUERIES ===###

  ###=== LEAGUE QUERIES ===###

  describe "#count_of_teams" do
    it "returns number of teams" do
      expect(@stat_tracker.count_of_teams).to eq 32
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
      expect(@stat_tracker.highest_scoring_visitor).to eq "Chicago Fire"
    end
  end

  describe "#highest_scoring_home_team" do
    it "names team with highest avg score when home across all seasons" do
      expect(@stat_tracker.highest_scoring_home_team).to eq "FC Dallas"
    end
  end

  describe "#lowest_scoring_visitor" do
    it "names team with lowest avg score when away across all seasons" do
      expect(@stat_tracker.lowest_scoring_visitor).to eq "Houston Dynamo"
    end
  end

  describe "#lowest_scoring_home_team" do
    it "names team with lowest avg score when home across all seasons" do
      expect(@stat_tracker.lowest_scoring_home_team).to eq "Chicago Fire"
    end
  end

  ###=== LEAGUE QUERIES ===###

  ###=== SEASON QUERIES ===###

  # helper
  describe "#coach_season_win_pct" do
    it "returns all coaching win pct by season" do
      expected = {"John Tortorella" => 0.0, "Claude Julien" => 100.0}
      expect(@stat_tracker.coach_season_win_pct("20122013")).to eq expected
    end
  end

  describe "#winningest_coach" do
    it "names coach with best win percentage for season" do
      expect(@stat_tracker.winningest_coach("20122013")).to eq "Claude Julien"
    end
  end

  describe "#worst_coach" do
    it "names coach with worst win pct for season" do
      expect(@stat_tracker.worst_coach("20122013")).to eq "John Tortorella"
    end
  end

  # helper
  describe "#team_accuracies" do
    it "should calculate team accuracies for a certain season" do
      expected_accuracies = {
        "6" => 0.29,
        "3" => 0.24,
      }
      expect(@stat_tracker.team_accuracies("20122013")).to eq expected_accuracies
    end
  end

  describe "#most_accurate_team" do
    it "should return the most accurate team" do
      expect(@stat_tracker.most_accurate_team("20122013")).to eq("FC Dallas")
    end
  end

  describe "#least_accurate_team" do
    it "should return the least accurate team" do
      expect(@stat_tracker.least_accurate_team("20122013")).to eq("Houston Dynamo")
    end
  end

  # helper
  describe "#season_team_tackles" do
    it "returns all teams tackles from given season" do
      expected = {"3"=>77, "6"=>115}
      expect(@stat_tracker.season_team_tackles("20122013")).to eq expected
    end
  end
  
  describe "#most_tackles" do
    it "takes season ID argument and finds team with most tackles in a single season" do
      expect(@stat_tracker.most_tackles("20122013")).to eq("FC Dallas")
    end
  end

  describe "#fewest_tackles" do
    it "takes season ID argument and finds team with fewest tackles in a single season" do
      expect(@stat_tracker.fewest_tackles("20122013")).to eq("Houston Dynamo")
    end
  end
end
