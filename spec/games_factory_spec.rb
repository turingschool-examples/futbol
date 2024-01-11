#do we need to require lib/games?  Why not just games_factory
# Should this be `Game` or `Games`
require './lib/games'
require './lib/games_factory'
require 'pry'

RSpec.describe GamesFactory do
  before do
        # if @file_path is an attribute, why is it in the before block?  
    @file_path = './data/game_fixture.csv'
    @games_factory = GamesFactory.new(@file_path)
  end

  describe 'initialize' do
    expect(@games_factory).to be_a(GamesFactory)
  end

    it 'has a file_path attributre' do
    expect(@games_factory.file_path).to eq(@file_path)
    end

  describe 'create_games' do
    it 'creates game objects from data stored in the file_path attribute' do
      expect(@games_factory.create_games).to be_a(Array)
      expect(@games_factory.create_games.all? {|game| game.class == Game}).to true
    end
  end
end