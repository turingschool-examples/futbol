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
      expect(@stat_tracker.percentage_home_wins).to eq(0.60)
    end
  end

  describe "#percentage_visitor_wins" do
    it "returns the percentage of home games a team has won" do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.30)
    end
  end

  describe "#percentage_ties" do
    it "returns the percentage of games ending in a tie" do
      expect(@stat_tracker.percentage_ties).to eq(0.10)
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

  describe "average_goals_by_season" do
    it "should return the average points per season" do
      expected_outcome = {
        "20122013" => 4.38,
        "20132014" => 4.00
      }
      expect(@stat_tracker.average_goals_by_season).to eq(expected_outcome)
    end
  end

  ###=== GAME QUERIES ===###

  ###=== LEAGUE QUERIES ===###

  describe "#count_of_teams" do
    it "returns number of teams" do
      expect(@stat_tracker.count_of_teams).to eq 32
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

  ###=== SEASON QUERIES ===###

  ###=== TEAM QUERIES ===###
  describe "#biggest_team_blowout" do
    it "returns the biggest goal differential" do
      expect(@stat_tracker.biggest_team_blowout("1")).to eq 2
    end
  end

  describe "#worst_loss" do
    it "returns the biggest loss for given team" do
      expect(@stat_tracker.worst_loss("3")).to eq(-2)
    end
  end

  describe "#team_info" do
    it "returns a hash with team information" do
      expected_team_info = {
        "abbreviation" => "ATL",
        "franchise_id" => "23",
        "link" => "/api/v1/teams/1",
        "team_id" => "1",
        "team_name" => "Atlanta United",
      }

      expect(@stat_tracker.team_info("1")).to eq(expected_team_info)
    end
  end

  describe "#head_to_head" do
    it "returns a hash of all opponents and their win_pct against" do
      expect(@stat_tracker.head_to_head("6")).to eq({"3" => 1.00})
    end
  end

  describe "#favorite_opponent" do
    it "returns the team name for the highest win pct against" do
      expect(@stat_tracker.favorite_opponent("6")).to eq "Houston Dynamo"
    end
  end

  describe "#rival" do
    it "returns the team name for the lowest win pct against" do
      expect(@stat_tracker.rival("3")).to eq "FC Dallas"
    end
  end

  describe "#seasonal_summary" do
    it "returns a hash with seasonal summary information" do
      expected = {average_goals_against: 1.6,
                  average_goals_scored: 2.8,
                  total_goals_against: 8,
                  total_goals_scored: 14,
                  win_percentage: 1.0}

      expect(@stat_tracker.seasonal_summary("6")["20122013"][:postseason]).to eq(expected)
    end
  end


  describe "#best_season(team_id)" do
    it "returns the best season for given team" do
      expect(@stat_tracker.best_season("6")).to be_a(String)
      expect(@stat_tracker.best_season("6")).to eq("20122013")
    end
  end

  describe "#worst_season(team_id)" do
    it "returns the worst season for given team" do
      expect(@stat_tracker.worst_season("6")).to be_a(String)
      expect(@stat_tracker.worst_season("6")).to eq("20132014")
    end
  end

  describe "#average_win_percentage(team_id)" do
    it "returns the average win percentage across all seasonss for given team" do
      expect(@stat_tracker.average_win_percentage("6")).to eq(1.00)
      expect(@stat_tracker.average_win_percentage("6")).to be_a(Float)
    end
  end

  describe '#most_goals_scored' do
    it 'returns the highest number of goals scored by any team in a single game' do
      expect(@stat_tracker.most_goals_scored("6")).to eq(3)
    end
  end

  describe '#fewest_goals_scored' do
    it 'returns the highest number of goals scored by any team in a single game' do
      expect(@stat_tracker.fewest_goals_scored("6")).to eq(2)
    end
  end

  ###=== TEAM QUERIES ===###
end
#to make new brnch 
