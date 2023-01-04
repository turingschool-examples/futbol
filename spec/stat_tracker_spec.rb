require './lib/stat_tracker'

describe StatTracker do
  let(:stat_tracker) {StatTracker.new({
                        :games => './data/games_spec.csv', 
                        :teams => './data/teams.csv', 
                        :game_teams => './data/game_teams.csv'
                        })}
  
  describe '#initialize' do
    it 'exists' do
      expect(stat_tracker).to be_a(StatTracker)
    end

    it 'has attributes' do
      expect(stat_tracker.games).to be_a(CSV::Table)
      expect(stat_tracker.teams).to be_a(CSV::Table)
      expect(stat_tracker.game_teams).to be_a(CSV::Table)
      expect(stat_tracker.game_id).to be_a(Array)
    end
  end

  describe '#highest_total_score' do
    it 'returns highest sum of the winning and losing teams scores' do
      expect(stat_tracker.highest_total_score).to eq(6)
    end
  end

  describe '#lowest_total_score' do
    it 'returns lowest sum of the winning and losing teams scores' do
      expect(stat_tracker.lowest_total_score).to eq(2)
    end
  end

  describe '#percentage_home_wins' do
    it 'returns percent of wins at home' do
      expect(stat_tracker.percentage_home_wins).to eq(0.33)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'returns percent of visitor wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.50)
    end
  end

  describe '#percentage_ties' do
    it 'returns percent of tied games' do
      expect(stat_tracker.percentage_ties).to eq(0.17)
    end
  end

  describe '#count_of_games_by_season' do
    it 'creates a hash with season names as keys and counts of games as values' do
      expected_hash = {
                        "20142015" => 3,
                        "20162017" => 1,
                        "20172018" => 1,
                        "20122013" => 1
                      }
      expect(stat_tracker.count_of_games_by_season).to eq(expected_hash)
    end
  end

  describe '#average_goals_per_game' do
    it 'determines the average goals per game' do
      expect(stat_tracker.average_goals_per_game).to eq(4.67)
    end
  end
end


















































































































































































  # describe '#count_of_teams' do
  #   it "counts all teams" do
  #     stat_tracker.count_of_teams
  #     expect(stat_tracker.count_of_teams).to eq 32
  #   end
  #end

  