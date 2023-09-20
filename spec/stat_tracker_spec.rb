require './spec/spec_helper'

RSpec.describe StatTracker do
  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'
  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  
  let(:stat_tracker) { StatTracker.from_csv(locations) }

  describe '#initialize' do
    it 'can initialize' do
      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  describe '::from_csv' do
    it 'returns an instance of StatTracker' do
      expect(stat_tracker).to be_a(StatTracker)
      expect(stat_tracker.team_data).to be_a(CSV::Table)
      expect(stat_tracker.game).to be_a(CSV::Table)
      expect(stat_tracker.game_teams).to be_a(CSV::Table)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'calculates the percentage of visitor wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.36)
    end
  end

  describe '#percentage_home_wins' do
    it 'calculates percentage home wins' do
      expect(stat_tracker.percentage_home_wins).to eq(0.44)
    end
  end

  describe '#highest_total_score' do
    it 'returns the highest sum of the winning and losing teams scores' do
      expect(stat_tracker.highest_total_score(true)).to eq(5)
    end
  end

  describe '#lowest_total_score' do
    it 'returns the lowest sum of the winning and losing teams scores' do
      expect(stat_tracker.lowest_total_score(true)).to eq(1)
    end
  end

end