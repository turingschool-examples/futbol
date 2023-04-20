require './spec_helper'

RSpec.describe Game do
  before(:each) do
    game_path = './data_dummy/games_dummy.csv'
    games_data = CSV.open(game_path, headers: true, header_converters: :symbol)
    @game = Game.new(games_data)
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

require './spec_helper'

RSpec.describe Game do
  before(:each) do
    game_path = './data_dummy/games_dummy.csv'
    games_data = CSV.open(game_path, headers: true, header_converters: :symbol)
    @game = Game.new(games_data)
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

>>>>>>> b1e6d5e71a4ee7bf6d5e23f8d0d51037ac79f6b7
end