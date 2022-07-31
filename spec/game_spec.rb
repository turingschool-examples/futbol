require 'spec_helper'
require_relative '../lib/stat_tracker'
require_relative '../lib/game'


RSpec.describe Game do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    data_set = StatTracker.from_csv(locations)
    @game_statistics = Game.new(data_set.data)
  end
  describe '.Game instantiation' do
    it 'is instance of class' do
      expect(@game_statistics).to be_an_instance_of(described_class)
    end
  end
  describe '.highest_total_score' do
    it 'can calculate the highest total score of a game' do
      expect(@game_statistics.highest_total_score).to eq(11)
    end
  end
  describe '.lowest_total_score' do
    it 'can calculate the lowest total score of a game' do
      expect(@game_statistics.lowest_total_score).to eq(0)
    end
  end
  describe '.percentage_home_wins' do
    it 'can calculate the percentage of home wins' do
      expect(@game_statistics.percentage_home_wins).to eq(0.44)
    end
  end
  describe '.percentage_away_wins' do
    it 'can calculate the percentage of away wins' do
      expect(@game_statistics.percentage_visitor_wins).to eq(0.36)
    end
  end
  describe '.percentage_ties' do
    it 'can calculate the total number of ties' do
      expect(@game_statistics.percentage_ties).to eq 0.20
    end
  end
  describe 'count_of_games_by_season' do 
    it 'can count number of games per season' do
       expected = {
        "20122013" => 806,
        "20162017" => 1317,
        "20142015" => 1319,
        "20152016" => 1321,
        "20132014" => 1323,
        "20172018" => 1355
      }
      expect(@game_statistics.count_of_games_by_season).to eq expected
    end
  end
  describe 'average_goals_per_game' do 
    it 'can calculate average goals per game scored across all seasons' do
      expect(@game_statistics.average_goals_per_game).to eq 4.22
    end
  end
  describe 'average_goals_by_season' do 
    it 'can calculate average goals per season' do
      expected = {
        "20122013" => 4.12,
        "20162017" => 4.23,
        "20142015" => 4.14,
        "20152016" => 4.16,
        "20132014" => 4.19,
        "20172018" => 4.44
      }
      expect(@game_statistics.average_goals_by_season).to eq expected
    end
  end
end