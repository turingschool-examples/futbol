require './spec/spec_helper'

RSpec.describe StatTracker do
  let(:stat_tracker) { StatTracker.new(locations) }
  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'
  let(:locations) { {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  }

  describe '#initialize' do
    it 'can initialize' do
      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  describe '::from_csv' do
    it 'returns an instance of StatTracker' do
      stat_tracker = StatTracker.from_csv(locations)
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


  describe '#average_goals_by_season' do
    it 'returns the average goals scored per season' do
      expected_value = { '20122013' => 3.86, '20142015' => 3.5, '20162017' => 4.75 }
      expect(stat_tracker.average_goals_by_season(true)).to eq(expected_value)
    end
  end

  describe '#worst_offense' do
    it 'can return the team with the lowest average number of goals per game across all seasons' do
      expect(stat_tracker.worst_offense).to eq("Utah Royals FC")
    end
  end
end