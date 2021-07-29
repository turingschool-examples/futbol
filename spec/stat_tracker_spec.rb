require_relative 'spec_helper'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/fixture_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/fixture_game_teams.csv'

    @file_paths = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.new(@file_paths)
  end


  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@stat_tracker).to be_instance_of(StatTracker)
      expect(@stat_tracker.game_manager).to be_instance_of(GameManager)
      expect(@stat_tracker.team_manager).to be_instance_of(TeamManager)
      expect(@stat_tracker.game_team_manager).to be_instance_of(GameTeamManager)
    end
  end

  describe '.from_csv(file_paths)' do
    it 'returns instance of StatTracker' do
      stats = StatTracker.from_csv(@file_paths)
      expect(stats).to be_instance_of(StatTracker)
    end
  end

  describe '#highest_total_score' do
    it 'highest_total_score' do
      expect(@stat_tracker.highest_total_score).to eq(5)
    end
  end

  describe '#lowest_total_score' do
    it 'lowest_total_score' do
      expect(@stat_tracker.lowest_total_score).to eq(1)
    end
  end
end
