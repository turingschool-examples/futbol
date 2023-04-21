require "csv"
require "spec_helper"

RSpec.describe GameStatistics do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @game_stats = GameStatistics.new(locations)
  end

  describe "#initialize" do
    it "exists" do
      expect(@game_stats).to be_a(GameStatistics)
      expect(@stat_tracker).to be_a(StatTracker)
    end
  end

  describe "#scores" do
    it "creates a list of scores for each game" do 
      expect(@game_stats.scores).to be_a(Array)
      expect(@game_stats.scores.sample).to be_a(Integer)
      expect(@game_stats.scores[0]).to eq(5)
    end
  end

  describe "#highest_total_score" do
    it "returns the highest sum of the winning and losing teams scores" do
      expect(@game_stats.highest_total_score).to eq(11)
    end
  end

  describe "#lowest_total_score" do
    it "returns the lowest sum of the winning and losing teams scores" do
      expect(@game_stats.lowest_total_score).to eq(0)
    end
  end

  describe "#percentage_home_wins" do
    it "returns a percentage of games that a home team has won as a float (rounded to the nearest 100th)" do
      
    end
  end


end