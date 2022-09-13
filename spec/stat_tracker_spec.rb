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
      # stat_tracker = StatTracker.new
      expect(@stat_tracker).to be_instance_of StatTracker
    end
  end

  describe '#self.from_csv' do
    it 'makes data accessible in class' do
      expect(@stat_tracker.games_data).to be_instance_of CSV
      expect(@stat_tracker.teams_data).to be_instance_of CSV
      expect(@stat_tracker.game_teams_data).to be_instance_of CSV
    end
  end

  describe '#game stats' do
    it 'can calculate the highest sum of the winning and losing teams scores' do 
        expect(@stat_tracker.highest_total_score).to eq 11
    end
  end

end