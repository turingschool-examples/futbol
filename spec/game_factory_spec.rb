#do we need to require lib/games?  Why not just games_factory
require './lib/game'
require './lib/game_factory'
require 'pry'

RSpec.describe GameFactory do
  before do
        # if @file_path is an attribute, why is it in the before block?  
    @file_path = './data/game_fixture.csv'
    @game_factory = GameFactory.new(@file_path)
  end

  describe 'initialize' do
    it 'exists' do
      expect(@game_factory).to be_a(GameFactory)
    end
    
    it 'has a file_path attributre' do
      expect(@game_factory.file_path).to eq(@file_path)
    end

    it 'starts with no games created' do
      expect(@game_factory.games).to eq([])
    end
  end

  describe 'create_games' do
    it 'creates game objects from data stored in the file_path attribute' do
      expect(@game_factory.create_games).to be_a(Array)
      expect(@game_factory.create_games.all? {|game| game.class == Game}).to be true
    end
  end

  describe 'count_of_goals' do
    
  end
end