require 'rspec'
require './lib/stat_tracker'

RSpec.describe StatTracker do 
  before(:each) do 
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#initialize' do
  end

  describe '#highest_total_score' do
    it 'returns highest total score of seasons games' do
      expect(@stat_tracker.highest_total_score).to eq(5)
    end
  end

  describe '#percentage_ties' do
    it 'returns the percent that the games have ended in a tie' do
      expect(@stat_tracker.percentage_ties).to eq(5.88)
    end
  end

  describe '#return_column' do 
    it 'is an integer' do 
      # allow(fake_data).to receive(:)
      # return_column(fake_data, header)
      

    end
  end
end