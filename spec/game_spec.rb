require './spec_helper'

RSpec.describe Game do
  before(:each) do
    @games_data = CSV.open('./data/games.csv', headers: true, header_converters: :symbol)
    @game = Game.new(@games_data)
  end

  describe "initialize" do
    it "exists" do
      expect(@game).to be_a(Game)
    end
  end

  describe "highest_total_score" do
    it "can find the highest sum of the winning and losing teams' scores" do
      expect(@game.highest_total_score).to eq(11)
    end
  end

  describe "lowest_total_score" do
    it "can find the lowest sum of the winning and losing teams' scores" do
      expect(@game.lowest_total_score).to eq(0)
    end
  end

end