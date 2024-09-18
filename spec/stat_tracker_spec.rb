require './spec/spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    game_path = './data/games_test.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_team_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.new
    @stat_tracker1 = StatTracker.from_csv(locations)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of(StatTracker)
      expect(@stat_tracker.all_games).to eq([])
      expect(@stat_tracker.all_teams).to eq([])
      expect(@stat_tracker.all_game_teams).to eq([])
    end
  end
  describe '#from_csv' do
    it 'can create a new Stattracker instance' do
      expect(@stat_tracker1).to_not eq(@stat_tracker)
    end

    it 'has created lists of variables' do
      expect(@stat_tracker1.all_games.count).to eq(32)
      expect(@stat_tracker1.all_teams.count).to eq(32)
      expect(@stat_tracker1.all_game_teams.count).to eq(29)
    end
  end
  describe '#calculate percentages' do
    it 'can calculate home wins' do
      expect(@stat_tracker1.percentage_home_wins).to eq(0.6875)
    end

    it 'can calculate visitor wins' do
      expect(@stat_tracker1.percentage_visitor_wins).to eq(0.2813)
    end

    it 'can calculate ties' do
      expect(@stat_tracker1.percentage_ties).to eq(0.313)
    end

    it 'can calculate accurately' do
      total = (@stat_tracker1.percentage_ties) + (@stat_tracker1.percentage_visitor_wins) + (@stat_tracker1.percentage_home_wins)
      expect(total).to be_within(0.003).of(1.0000)
    end
  end

  describe '#highest_total_score' do
    it 'returns the highest sum of the winning and losing teams’ scores' do
      expect(@stat_tracker1.highest_total_score).to eq('41')
    end
  end
  describe '#lowest_total_score' do
    it 'returns the lowest sum of the winning and losing teams’ scores' do
      expect(@stat_tracker1.lowest_total_score).to eq('03')
    end
  end

  describe '#get_scores' do
    it 'returns an array of all scores for a team_id' do
      expect(@stat_tracker1.get_scores(6)).to eq([3, 3, 3, 2, 1, 2, 3, 3, 4])
      expect(@stat_tracker1.get_scores('6')).to eq([3, 3, 3, 2, 1, 2, 3, 3, 4])
      expect(@stat_tracker1.get_scores('1')).to eq([0])

      expect(@stat_tracker1.get_scores(6, :home)).to eq([3, 3, 3, 2, 1])
      expect(@stat_tracker1.get_scores(6, :away)).to eq([2, 3, 3, 4])
      expect(@stat_tracker1.get_scores(6, :total)).to eq([3, 3, 3, 2, 1, 2, 3, 3, 4])
      expect(@stat_tracker1.get_scores(6, :blahblah)).to eq([3, 3, 3, 2, 1, 2, 3, 3, 4])
    end
  end

  describe '#offensive performance' do
    it 'can show the best offense overall' do
      expect(@stat_tracker1.best_offense).to eq("FC Dallas")
    end
    it 'can show the worst offense overall' do
      expect(@stat_tracker1.worst_offense).to eq("Sporting Kansas City")
    end 
  end
end
