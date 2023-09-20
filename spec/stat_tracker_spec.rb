require "./spec/spec_helper"

RSpec.describe StatTracker do

  before :each do
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
      expect(@stat_tracker.percentage_home_wins).to eq(60.0)
    end
  end

  describe "#percentage_visitor_wins" do
    it "returns the percentage of home games a team has won" do
      expect(@stat_tracker.percentage_visitor_wins).to eq(30.0)
    end
  end

  describe '#percentage_ties' do
    it 'returns the percentage of games ending in a tie' do
      expect(@stat_tracker.percentage_ties).to eq(10.0)
    end

  describe "#count_of_games_by_season" do
    it "returns the number of games in a season" do

      expected_outcome = {
        '20122013' => 8,
        '20132014' => 2
      }
      expect(@stat_tracker.count_of_games_by_season).to eq(expected_outcome)
    end
  end

  describe "average_goals_per_game" do
    it "should return the average goals per game" do
      expect(@stat_tracker.average_goals_per_game).to eq(4.3)  
    end
  end

  describe "average_goals_per_season" do
    it "should return the average points per season" do
      expected_outcome = {
        '20122013' => 4.38,
        '20132014' => 4.0
      }
      expect(@stat_tracker.average_goals_per_season).to eq(expected_outcome)
    end

  end
end
