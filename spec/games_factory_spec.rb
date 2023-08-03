require 'spec_helper'

describe GamesFactory do 
  before(:each) do 
    @games = GamesFactory.new 
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@games).to be_a GamesFactory
    end
  end 

  describe '#create_games' do
    it 'can add games' do
      expect(@games.create_games("./data/games.csv")).to be_an Array
      expect(@games.create_games("./data/games.csv")).to all be_a Game

      @games.create_games("./data/games.csv")

      expect(@games.games[0].game_id).to eq(2012030221)
      expect(@games.games[0].season).to eq(20122013)
      expect(@games.games[0].type).to eq("Postseason")
      expect(@games.games[0].date_time).to eq("5/16/13")
      expect(@games.games[0].away_team_id).to eq(3)
      expect(@games.games[0].home_team_id).to eq(6)
      expect(@games.games[0].away_goals).to eq(2)
      expect(@games.games[0].home_goals).to eq(3)
      expect(@games.games[0].venue).to eq("Toyota Stadium")
    end 
  end
end
