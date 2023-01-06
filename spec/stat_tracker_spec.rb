require './lib/stat_tracker'
# require './spec/spec_helper'

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

  describe '#total_score' do
    it 'calculates the total number of goals' do
      expect(stat_tracker.total_score).to be_a(Array)
      expect(stat_tracker.total_score.sum).to eq(36)
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
      expect(stat_tracker.percentage_home_wins).to eq(0.25)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'returns percent of visitor wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.63)
    end
  end

  describe '#percentage_ties' do
    it 'returns percent of tied games' do
      expect(stat_tracker.percentage_ties).to eq(0.13)
    end
  end

  describe '#count_of_teams' do
    it "counts all teams" do
      stat_tracker.count_of_teams
      expect(stat_tracker.count_of_teams).to eq 32
    end
  end

  describe '#best_offense' do
    it "name of the team with the highest average number of goals scored per game across all seasons" do
      expect(stat_tracker.best_offense).to eq "Sporting Kansas City"
    end
  end

  describe '#worst_offense' do
    it "name of the team with the lowest average number of goals scored per game across all seasons" do
      expect(stat_tracker.worst_offense).to eq "Houston Dynamo"
    end
  end

  describe '#highest_scoring_visitor' do
    it "#count_of_away_games_by_id" do
      expect(stat_tracker.count_of_away_games_by_id).to be_a(Hash)
    end
  end

  describe '#highest_scoring_visitor' do
    xit "#team with the highest average score per game across all seasons when they are away" do
      expect(stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
    end

    
  end
end





