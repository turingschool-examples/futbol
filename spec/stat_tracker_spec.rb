require_relative 'spec_helper'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './spec/fixtures/games_fixture.csv'
    team_path = './spec/fixtures/teams_fixture.csv'
    game_teams_path = './spec/fixtures/game_teams_fixture.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end
 
  it "exists" do 
   expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end
  
  describe '#highest_total_score' do 
    it 'returns the highest sum of the winning and losing teams scores' do 
      expect(@stat_tracker.highest_total_score).to eq(6)
    end
  end

  describe '#lowest_total_score' do 
    it ' is the lowest sum of the wining and losing teams scores' do 
      expect(@stat_tracker.lowest_total_score).to eq(1)
    end
  end

  describe '#all_scores' do 
    it 'is a helper method for highest and lowest total score methods' do 
      expect(@stat_tracker.all_scores.class).to eq(Array)
    end
  end

  describe '#percentage_home_wins' do 
    it 'is the percentage of games that a home team has won' do 
      expect(@stat_tracker.percentage_home_wins).to eq(0.53)
    end
  end

  describe '#home_wins_array' do 
    it 'is a helper method for percentage_home_wins, array of home goals greater than away goals' do 
      expect(@stat_tracker.home_wins_array.class).to eq(Array)
    end
  end
  
  describe '#average_goals_per_game' do
    it 'finds the average number of goals per game' do
      expect(@stat_tracker.average_goals_per_game).to eq(4.00)
    end
  end

  describe '#average_goals_by_season' do
    it 'finds the average goals per game per season' do
      expect(@stat_tracker.average_goals_by_season.class).to eq(Hash)
      expect(@stat_tracker.average_goals_by_season).to eq(
        {"20122013"=>4.05, "20132014"=>3.88} )
    end
  end

  describe '#count_of_teams' do
    it 'finds the total number of teams' do
      expect(@stat_tracker.count_of_teams).to eq(32)
    end
  end
end