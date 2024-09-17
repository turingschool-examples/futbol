require './spec/spec_helper'

RSpec.describe Stattracker do
  before(:each) do
    game_path = './data/games_test.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_team_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = Stattracker.new
    @stat_tracker1 = Stattracker.from_csv(locations)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of(Stattracker)
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
  
  describe '#highest_total_score' do
    it 'returns the highest sum of the winning and losing teams’ scores' do
      expect(@stat_tracker1.highest_total_score).to eq("41")
    end
  end

  describe '#lowest_total_score' do
    it 'returns the lowest sum of the winning and losing teams’ scores' do
      expect(@stat_tracker1.lowest_total_score).to eq("03")
    end
  end
  
  describe '#coach_win_percentages' do
    it 'calculates winning percentages of coaches' do
      expected = {
        "Claude Julien"=>1.0, 
        "Dan Bylsma"=>0.0, 
        "Joel Quenneville"=>0.3333333333333333, 
        "John Tortorella"=>0.0, 
        "Mike Babcock"=>0.6
      }
      expect(@stat_tracker1.send(:coach_win_percentages)).to eq(expected)
    end
  end

  describe '#winningest_coach' do
    it 'returns highest winning percentage coach' do
      expect(@stat_tracker1.winningest_coach).to eq("Claude Julien")
    end
  end
end