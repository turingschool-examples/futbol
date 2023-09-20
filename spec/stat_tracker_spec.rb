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
  end
end
