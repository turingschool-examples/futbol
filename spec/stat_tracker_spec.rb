require './spec/spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    game_path = './data/games_test.csv'
    team_path = './data/teams.csv'
    team_path_2 = './data/teams_test.csv'
    game_teams_path = './data/game_team_test.csv'
    game_path_2 = './data/games_test_2.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    locations2 = {
      games: game_path_2,
      teams: team_path_2,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.new
    @stat_tracker1 = StatTracker.from_csv(locations)
    @stat_tracker2 = StatTracker.from_csv(locations2)
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
      expect(@stat_tracker1.percentage_home_wins).to eq(68.75)
    end

    it 'can calculate visitor wins' do
      expect(@stat_tracker1.percentage_visitor_wins).to eq(28.13)
    end

    it 'can calculate ties' do
      expect(@stat_tracker1.percentage_ties).to eq(3.13)
    end

    it 'can calculate accurately' do
      total = (@stat_tracker1.percentage_ties) + (@stat_tracker1.percentage_visitor_wins) + (@stat_tracker1.percentage_home_wins)
      expect(total).to be_within(0.03).of(100.00)
    end
  end

  describe '#highest_total_score' do
    it 'returns the highest sum of the winning and losing teams’ scores' do
      expect(@stat_tracker1.highest_total_score).to eq(5)
    end
  end

  describe '#lowest_total_score' do
    it 'returns the lowest sum of the winning and losing teams’ scores' do
      expect(@stat_tracker1.lowest_total_score).to eq(1)
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
 
  describe '#highest_scoring_home_team' do
    it 'can find the highest scoring home team' do
      expect(@stat_tracker2.highest_scoring_home_team).to eq('FC Dallas')
    end
  end

  describe '#highest_scoring_visitor' do
    it 'can find the highest scoring visiting team' do
      expect(@stat_tracker2.highest_scoring_visitor).to eq('FC Dallas')
    end
  end

  describe '#lowest_scoring_home_team' do
    it 'can find the lowest scoring home team' do
      expect(@stat_tracker2.lowest_scoring_home_team).to eq('Sporting Kansas City')
    end
  end

  describe '#lowest_scoring_visitor' do
    it 'can find the lowest scoring visiting team' do
      expect(@stat_tracker2.lowest_scoring_visitor).to eq('New York Red Bulls')
    end
  end
  
  describe '#coach_win_percentages' do
    it 'calculates winning percentages of coaches' do
      expected = {
        "Claude Julien"=>100, 
        "Dan Bylsma"=>0, 
        "Joel Quenneville"=>33, 
        "John Tortorella"=>0, 
        "Mike Babcock"=>60
      }
      expect(@stat_tracker1.send(:coach_win_percentages)).to eq(expected)
    end
  end

  describe '#winningest_coach' do
    it 'returns highest winning percentage coach' do
      expect(@stat_tracker1.winningest_coach).to eq("Claude Julien")
    end
  end

  describe '#worst_coach' do
    it 'returns lowest percentage coach' do
      expect(@stat_tracker1.worst_coach).to eq("John Tortorella")
    end
  end

  describe '#average_goals_per_game' do
    it 'calculates the correct average' do
      expect(@stat_tracker1.average_goals_per_game).to eq(3.75)
      expect(@stat_tracker1.average_goals_per_game).to_not eq(4)
    end
  end

  describe '#count_of_all_goals' do
    it 'counts all goals' do
      expect(@stat_tracker1.count_of_all_goals).to eq(120)
      expect(@stat_tracker1.count_of_all_goals).to_not eq(0)
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

  describe '#team_shot_goal_ratio' do
    it 'calculates accuracy ratio of a team' do
      binding.pry
      result = @stat_tracker1.team_shot_goal_ratios
    end
  end
end
