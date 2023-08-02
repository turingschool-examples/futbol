require "spec_helper"

RSpec.describe GameStatistics do
  before :each do
    @game_stats = GameStatistics.new
  end

  describe "#highest_total_score" do
    it "finds the highest total score from stat data" do
      expect(@game_stats.highest_total_score).to eq(5)
    end
  end

  describe "lowest_total_score" do
    it "finds the lowest total score from stat data" do
      expect(@game_stats.lowest_total_score).to eq(1)
    end
  end

  describe "percentage_home_wins" do
    it "finds percentage of games that a home team has won(rounded to nearedst 100th)" do
      expect(@game_stats.percentage_home_wins).to eq(0.68)
    end
  end

  describe "percentage_away_wins" do
    it "finds percentage of games that a visitor team has won(rounded to nearedst 100th)" do
      expect(@game_stats.percentage_visitor_wins).to eq(0.26)
    end
  end

  describe "percent ties" do
    it "finds percntage of tied away and home games" do
      expect(@game_stats.percentage_ties).to eq(.05)
    end
  end
end