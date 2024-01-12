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
  end

    it 'has a file_path attributre' do
    expect(@game_factory.file_path).to eq(@file_path)
    end

  describe 'create_games' do
    it 'creates game objects from data stored in the file_path attribute' do
      expect(@game_factory.create_games).to be_a(Array)
      expect(@game_factory.create_games.all? {|game| game.class == Game}).to be true
    end
  end

  describe '#total_score' do
    it 'should return array of integers that is the sum of away_goals and home_goals' do
      @game_factory.create_games

      expect(@game_factory.total_score).to be_a(Array)
      expect(@game_factory.total_score).to eq([5, 5, 3, 5, 4, 3, 5, 3, 1, 3, 3, 4, 2, 3, 5, 3, 4, 4, 5, 5])

    end
  end
  #we only have post_season for our fixture file here. Should we include regular_season games as well?
  # and then we have 20122013 regular_season and/or post_season games?
  # then with the total_score method we could have total_score for regular_season and/or post_season?
  describe '#season_games' do
    it 'returns an integer of number of games from specified season' do
      @game_factory.season_games(season)

      expect(@game_factory.season_games(season)).to be_a(Integer)
      expect(@game_factory.season_games(20122013)).to eq(20)
    
    end
  end
    #the count_of_games seems like it would be testing the same as above method. I am a little unsure about this one.
    # the total count of games in a season would include both regular_season and post_season 
  describe '#count_of_games' do
    it 'returns an integer of all games that are listed' do
      @game_factory.count_of_games

      expect(@game_factory.count_of_games).to be_a(Integer)
      expect(@game_factory.count_of_games).to eq(20)
    end
  end

end