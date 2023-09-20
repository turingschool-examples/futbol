require './spec/spec_helper'

RSpec.describe StatTracker do
  game_path = './data/games_fixture.csv'
  team_path = './data/teams_fixture.csv'
  game_teams_path = './data/game_teams_fixture.csv'
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
      expect(stat_tracker.percentage_visitor_wins).to eq(0.20)
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

  describe '#percentage_ties' do
    it 'calculates the percentage of tied games' do
      expect(stat_tracker.percentage_ties).to eq(0.35)
    end
  end

  describe '#lowest_total_score' do
    it 'returns the lowest sum of the winning and losing teams scores' do
      expect(stat_tracker.lowest_total_score(true)).to eq(1)
    end
  end


  describe '#average_goals_per_game' do
    it 'returns the average number of goals scored by a single team' do
      expect(stat_tracker.average_goals_per_game(true)).to eq(1.85)
    end
  end

  describe '#count_of_teams' do
    it 'returns the total number of teams' do
      expect(stat_tracker.count_of_teams).to eq(32)
    end
  end

  describe '#average_goals_by_season' do
    it 'returns the average goals scored per season' do
      expected_value = { '20122013' => 3.86, '20142015' => 3.5, '20162017' => 4.75 }
      expect(stat_tracker.average_goals_by_season(true)).to eq(expected_value)
    end
  end

  describe '#worst_offense' do
    it 'can return the team with the lowest average number of goals per game across all seasons' do
      expect(stat_tracker.worst_offense).to eq("Seattle Sounders FC")
    end
  end
end