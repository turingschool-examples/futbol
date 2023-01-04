require_relative 'spec_helper'

RSpec.describe StatTracker do
  let(:game_path) {'./spec/fixtures/games.csv'}
  let(:team_path) {'./spec/fixtures/teams.csv'}
  let(:game_teams_path) {'./spec/fixtures/game_teams.csv'}
  let(:locations) do
      {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    end

  let(:stat_tracker) { StatTracker.from_csv(locations) }
    
  it 'exists' do
      expect(StatTracker.from_csv(locations)).to be_an_instance_of(StatTracker)
  end

  describe '#highest_total_score' do
    it 'can get highest total score' do
      expect(stat_tracker.highest_total_score).to eq(7)
    end
  end

  describe '#lowest_total_score' do
    it 'can get lowest total score' do
      expect(stat_tracker.lowest_total_score).to eq(2)
    end
  end

  describe '#games_total_scores_array' do
    it 'returns array of total scores' do
      expect(stat_tracker.games_total_scores_array.first).to be_a(Integer)
      expect(stat_tracker.games_total_scores_array).to be_a(Array)
    end
  end
end
