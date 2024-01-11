require './lib/game'
require './lib/game_factory'
require 'pry'

RSpec.describe GameFactory do
  before do  
    @file_path = './data/game_fixture.csv'
    @game_factory = GameFactory.new(@file_path)
    @season_id = 20122013
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

  describe 'count_of_goals(season_id)' do
    it 'returns an integer' do
      expect(@game_factory.count_of_goals(@season_id).class).to eq(Integer)
    end
    
    it 'returns the sum of away and home goals for every game per season' do
      expect(@game_factory.count_of_goals(@season_id)).to eq(75)
    end
  end
  
  describe 'games_by_team(team_id)' do
     it 'returns an array of game objects when the either the home or away team matches the team_id argument' do
     end
     
  end

  describe 'goals_by_team(team_id)' do
    it 'returns an array of integers where the integers are the goals scored per game by the team that matches the team_id argument (this should be called on the array of the games_by_team(team_id) method)' do

    end
  end
end