require "csv"
require "./lib/game_stats"
require 'pry'


RSpec.describe GameStats do
  before :each do
    @game_stats = GameStats.new
  end

  describe "game_stats exists" do
    it 'exists' do
      expect(@game_stats).to be_an_instance_of GameStats
    end
  end

  describe "#highest_total_score" do
    it 'finds the highest sum of the winning and losing teams scores' do
      # binding.pry
      expect(@game_stats.highest_total_score).to eq(7)
    end
  end

  describe "#lowest_total_score" do
    it 'finds the lowest sum of the winning and losing teams scores' do
      # binding.pry
      expect(@game_stats.lowest_total_score).to eq(1)
    end
  end

  describe "#percentage_home_wins" do
    it 'finds the percentage of games that a home team has won (rounded to the nearest 100th)' do
      # binding.pry
      expect(@game_stats.percentage_home_wins).to eq()
    end
  end

  describe "#percentage_visitor_wins" do
    xit 'finds the percentage of games that a visitor has won (rounded to the nearest 100th)' do
      # binding.pry
      expect(@game_stats.lowest_total_score).to eq()
    end
  end
  
  describe "#percentage_ties" do
    xit 'finds the percentage of games that has resulted in a tie (rounded to the nearest 100th)' do
      # binding.pry
      expect(@game_stats.lowest_total_score).to eq()
    end
  end

  describe "#count_of_games_by_season" do
    xit 'creates a hash with season names (e.g. 20122013) as keys and counts of games as values' do
      # binding.pry
      expect(@game_stats.lowest_total_score).to eq()
    end
  end
  
  describe "#average_goals_per_game" do
    xit 'finds the average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)' do
      # binding.pry
      expect(@game_stats.lowest_total_score).to eq()
    end
  end

  describe "#average_goals_by_season" do
    xit 'finds the average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)' do
      # binding.pry
      expect(@game_stats.lowest_total_score).to eq()
    end
  end
end
