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

  describe '#highest_scoring_home_team' do
    it 'can find the highest scoring home team' do
      expect(true).to eq(false)
    end
  end

  describe '#highest_scoring_visitor' do
    it 'can find the highest scoring visiting team' do
      expect(true).to eq(false)
    end
  end

  describe '#lowest_scoring_home_team' do
    it 'can find the lowest scoring home team' do
      expect(true).to eq(false)
    end
  end

  describe '#lowest_scoring_visitor' do
    it 'can find the lowest scoring visiting team' do
      expect(true).to eq(false)
    end
  end
end