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
      expect(@game_stats.percentage_home_wins).to be_a(Float)
      expect(@game_stats.percentage_home_wins).to eq(0.44)
    end
  end

  describe "#percentage_visitor_wins" do
    it "returns a percentage of games that a visiting team has won as a float (rounded to the nearest 100th)" do
      expect(@game_stats.percentage_visitor_wins).to be_a(Float)
      expect(@game_stats.percentage_visitor_wins).to eq(0.36)
    end
  end

  describe "#percentage_ties" do
    it "returns a percentage of games that both teams have won as a float (rounded to the nearest 100th)" do
      expect(@game_stats.percentage_ties).to be_a(Float)
      expect(@game_stats.percentage_ties).to eq(0.20)
    end
  end

  describe "#count of games by season" do
    it "returns a hash of season names as keys with counts of games as values" do
      expected = {"20122013"=>806,
                  "20162017"=>1317,
                  "20142015"=>1319,
                  "20152016"=>1321,
                  "20132014"=>1323,
                  "20172018"=>1355}
      expect(@game_stats.count_of_games_by_season).to eq(expected)
      expect(@game_stats.count_of_games_by_season).to be_a(Hash)
    end
  end

  describe "#average_goals_per_game" do 
      it "can calculate the average goals per game" do 
        expect(@game_stats.average_goals_per_game).to be_a(Float)
        expect(@game_stats.average_goals_per_game).to eq(4.22)
      end
    end

  describe "#average_goals_by_season" do 
    it "can calculate the average goals per season" do 
      expect(@game_stats.average_goals_by_season).to be_a(Hash)
      expect(@game_stats.average_goals_by_season.keys[0]).to be_a (String)
      expect(@game_stats.average_goals_by_season.values[0]).to be_a (Float)
    end
  end
end
