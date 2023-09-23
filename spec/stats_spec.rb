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
      expect(@stat_tracker.percentage_results).to eq({away_wins: 0.30, home_wins: 0.60, ties: 0.10})
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

  describe "#win_pct_opp" do
    it "returns win_pct against opp data" do
      expect(@stat_tracker.win_pct_opp["6"][:head_to_head]).to eq({"3" => 1.00})
    end
  end
  ##== TEAM ==##

  ##== SEASON STATS AND HELPERS==##
  describe "#win_percentage" do
    it "returns percentage of games won that season for a team" do
      expect(@stat_tracker.win_percentage("Postseason", "20122013", "6")).to eq 1.0
    end
  end

  describe "#total_goals_scored" do
    it "returns total goals scored for a team in a season" do
      expect(@stat_tracker.total_goals_scored("Postseason", "20122013", "6")).to eq(14)
    end
  end

  describe "#total_goals_against" do
    it "returns total goals scored against a team in a season" do
      expect(@stat_tracker.total_goals_against("Postseason", "20122013", "6")).to eq(8)
    end
  end

  describe "#average_goals_scored" do
    it "returns the average goals scored for a team in a season" do
      expect(@stat_tracker.average_goals_scored("Postseason", "20122013", "6")).to eq(2.8)
    end
  end

  describe "#average_goals_against" do
    it "returns the average goals scored against a team in a season" do
      expect(@stat_tracker.average_goals_against("Postseason", "20122013", "6")).to eq(1.6)
    end
  end

  describe "#season_stats" do
    it "creates a new hash of season stats" do
      expected = {average_goals_against: 1.6,
                  average_goals_scored: 2.8,
                  total_goals_against: 8,
                  total_goals_scored: 14,
                  win_percentage: 1.0}
      expect(@stat_tracker.season_stats("Postseason", "20122013", "6")).to be_a Hash
      expect(@stat_tracker.season_stats("Postseason", "20122013", "6")).to eq(expected)
    end
  end

  describe "#seasonal_summaries" do
    it "creates a new hash of seasonal stats" do
      expected = {average_goals_against: 1.6,
                  average_goals_scored: 2.8,
                  total_goals_against: 8,
                  total_goals_scored: 14,
                  win_percentage: 1.0}
      expect(@stat_tracker.seasonal_summaries["6"]).to be_a Hash
      expect(@stat_tracker.seasonal_summaries["6"]["20122013"][:postseason]).to eq(expected)
    end
  end

  describe "#percent_wins" do
    it "creates a hash with all teams and hashes with their win percentages" do
      expect(@stat_tracker.percent_wins["6"]["20122013"]).to eq(100.00)
    end
  end

  describe "#average_wins" do
    it "creates a hash with all teams and their average wins over all games" do
      expect(@stat_tracker.average_wins["6"]).to eq(1.0)
    end
  end

  describe '#max_min_goals' do
    it "creates an array goals scored totals" do
      
      expect(@stat_tracker.max_min_goals).to eq({:highest_goals=>{"3"=>2, "4"=>4, "6"=>3}, :lowest_goals=>{"3"=>2, "4"=>1, "6"=>2}})  
    end
  end
end
