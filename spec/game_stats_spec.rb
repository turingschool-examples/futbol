require './lib/game_stats'
require './lib/game'
require 'csv'

describe GameStats do
  let(:game_stats) {game_stats = GameStats.new('data/games.csv')}
  describe "#initialize" do
    it "exists" do

      expect(game_stats).to be_a(GameStats)
    end
    
    it "reads in a csv and creats game objects" do

      expect(game_stats.games).to all be_a(Game)
    end
  end

  describe "#highest_total_score" do
    xit "returns the highest combined game score" do

      expect(game_stats.highest_total_score).to eq(11)
    end
  end
end

  