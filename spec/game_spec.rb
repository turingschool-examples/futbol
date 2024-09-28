require 'spec_helper'

RSpec.describe Game do
  before (:all) do
    fixture_game_path = 'spec/fixture/games_fixture.csv'

    locations = {
      games: fixture_game_path
    }
    
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @game = Game.new(@games_data) 
  end

  describe '#initialize' do
    it 'exists' do
      expect(@game).to be_an_instance_of(Game)
    end
  end

  describe '#game stats' do
    it 'can find total game score for each game' do 
      expect(@game.total_game_goals.count).to eq(140)
      expect(@game.total_game_goals[4]).to eq(4)
    end

    it 'can calculate the highest sum of the winning and losing teams scores' do 
      expect(@game.highest_total_score).to eq(7)
    end

    it 'can calculate the lowest sum of the winning and losing teams scores' do
      expect(@game.lowest_total_score).to eq(1)
    end

    it 'can calculate the percentage of games that a home team has won (to nearest 100th)' do
      expect(@game.percentage_home_wins).to eq(0.38)
    end

    it 'can calculate the percentage of games that an visitor team has won (to nearest 100th)' do
      expect(@game.percentage_visitor_wins).to eq(0.39)
    end

    it 'can calculate percentage of games that has resulted in a tie (rounded to the nearest 100th)' do
      expect(@game.percentage_ties).to eq(0.24)
    end

    it 'can calculate number of games by season' do
      expected = {
        "20122013"=>17,
        "20162017"=>6,
        "20142015"=>99,
        "20152016"=>7,
        "20132014"=>11,
      }
      expect(@game.count_of_games_by_season).to eq expected
    end

    it 'can calculate the average goals per game' do 
      expect(@game.average_goals_per_game).to eq 4.22
    end

    it 'can calculate the average goals by season' do
      expected = {
      "20122013"=>3.76,
      "20162017"=>4.17,
      "20142015"=>4.22,
      "20152016"=>4.71,
      "20132014"=>4.64,
      }
      expect(@game.average_goals_by_season).to eq expected
    end
  end

end