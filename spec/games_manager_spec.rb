require 'spec_helper'

RSpec.describe GamesManager do
  context 'games_manager' do

    games_manager = GamesManager.new('./data/mini_games.csv')

    it "has attributes" do
      expect(games_manager.games).not_to be_empty
    end

    it 'makes games' do
      expect(games_manager).to respond_to(:make_games)
    end

    it 'has highest and lowest total scored' do
      expect(games_manager.highest_total_score).to eq(7)
      expect(games_manager.lowest_total_score).to eq(1)
    end

    it 'counts games per season' do
      expected = {
        '20132014' => 6,
        '20142015' => 19,
        '20152016' => 9,
        '20162017' => 17
      }
      expect(games_manager.count_of_games_by_season).to eq(expected)
    end

    it 'has average goals by season' do
      expected = {
        "20142015"=>3.63,
        "20152016"=>4.33,
        "20132014"=>4.67,
        "20162017"=>4.24
      }
      expect(games_manager.average_goals_by_season).to eq(expected)
    end

    it 'goals per season' do
      expect(games_manager).to respond_to(:goals_per_season)
    end

    it 'goals per game' do
      expect(games_manager).to respond_to(:goals_per_game)
    end

    it 'has average goals per game' do
      expect(games_manager.average_goals_per_game).to eq(4.08)
    end

    it 'games per season' do
      expect(games_manager.games_per_season('20132014')).to eq(6)
    end

    it 'highest scoring vistor and home team' do
      expect(games_manager.highest_scoring_visitor).to eq("5")
      expect(games_manager.highest_scoring_home_team).to eq("24")
    end

    it 'lowest scoring vistor and home team' do
      expect(games_manager.lowest_scoring_visitor).to eq("13")
      expect(games_manager.lowest_scoring_home_team).to eq("13")
    end

    it 'has a favourite opponent' do
      expect(games_manager.favorite_opponent("15")).to eq("10")
    end

    it 'has a rival' do
      expect(games_manager.rival("15")).to eq("2")
    end

    it 'calcs win percents' do

    end
  end
end
