require './spec_helper'
require_relative '../lib/stat_tracker'
require_relative '../lib/league_statistics'

RSpec.describe LeagueStatistics do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    data_set = StatTracker.from_csv(locations)
    @league_statistics = LeagueStatistics.new(data_set)
  end
  describe '.LeagueStatistics instantiation' do
    it 'is instance of class' do
      expect(@league_statistics).to be_an_instance_of(described_class)
    end
  end
  describe '.count_of_teams' do
    it 'has a count of teams' do
      expect(@league_statistics.count_of_teams).to eq(32)
    end
  end
  describe '.total_team_goal_averages' do
    it 'can return a hash of average total goals by team id' do
      expect(@league_statistics.total_team_goal_averages).to be_a(Hash)
      expect(@league_statistics.total_team_goal_averages["54"]).to eq(2.34)
    end
  end
  describe '.best_offense' do
    it 'can return the name of the team with best offense' do
      expect(@league_statistics.best_offense).to eq("Reign FC")
    end
  end
  describe '.worst_offense' do
    it 'can return the name of the team with worst offense' do
      expect(@league_statistics.worst_offense).to eq("Utah Royals FC")
    end
  end
end