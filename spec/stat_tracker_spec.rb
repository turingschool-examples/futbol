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

  describe '#return_column' do
    it 'is an integer' do
      # allow(fake_data).to receive(:)
      # return_column(fake_data, header)
    end
  end

  describe 'count_of_games_by_season' do
    it 'does something' do
      expect(@stat_tracker.count_of_games_by_season).to eq(1)
    end
  end

  describe '#average_goals_by_season' do
    it 'tabulates average goals by season' do
      # require 'pry'; binding.pry
      expect(@stat_tracker.average_goals_by_season).to eq({"20122013"=>3.78})
    end
  end
end