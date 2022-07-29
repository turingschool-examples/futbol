require 'spec_helper'
require_relative '../lib/stat_tracker'
require_relative '../lib/game_statistics'


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
end