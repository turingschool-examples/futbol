require 'rspec'
require 'simplecov'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end
  end

  describe '#game stats' do
    it 'can calculate the highest sum of the winning and losing teams scores' do 
      expect(@stat_tracker.highest_total_score).to eq(11)
    end

    it 'can calculate the lowest sum of the winning and losing teams scores' do 
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end

    it ' can calculate the percentage of games that a home team has won (to nearest 100th)' do 
      expect(@stat_tracker.percentage_home_wins).to eq(0.44)
    end

    it ' can calculate the percentage of games that an away team has won (to nearest 100th)' do 
      expect(@stat_tracker.percentage_away_wins).to eq(0.36)
    end
  end

end