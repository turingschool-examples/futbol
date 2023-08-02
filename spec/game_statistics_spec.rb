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
      expect(@game_stats.highest_total_score).to eq(1)
    end
  end

end