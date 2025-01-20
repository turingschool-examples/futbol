require './spec/spec_helper'

describe GameFactory do
  before(:each) do
    game_path = './data/games.csv'

    @games = GameFactory.create_games(game_path)
  end

  describe '::create_games' do
    it 'returns an array of Game objects' do
      expect(@games).to be_a(Array)
      expect(@games[0]).to be_a(Game)
    end

    it 'returns a collection of Game objects created with external CSV data' do
      expect(@games[0].game_id).to eq("2012030221")
    end
  end
end