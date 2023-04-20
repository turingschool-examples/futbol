require "./spec_helper"

RSpec.describe Game do
  before(:each) do
    @game = Game.new("./data/game_teams.csv",)
  end
  describe "win percentages" do
    it "can count total games" do
      expect(@game.game_count).to eq(14882)
    end
    it "returns win percentages" do
      expect(@game.percentage_home_wins).to be_a(Float)
    end

  end
end