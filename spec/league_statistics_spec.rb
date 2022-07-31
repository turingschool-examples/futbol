require 'spec_helper'
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

    @data_set = StatTracker.from_csv(locations)
    @league_statistics = LeagueStatistics.new(@data_set.data)
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
  describe '.team_goal_stats_averages' do
    it 'can return a hash of average goals for a team across all games when passed an argument' do
      expect(@league_statistics.team_goal_stats_averages).to be_a(Hash)
      expect(@league_statistics.team_goal_stats_averages["17"]).to eq(2.06)
      expect(@league_statistics.team_goal_stats_averages("home") == @league_statistics.team_goal_stats_averages).to eq(false)
      expect(@league_statistics.team_goal_stats_averages("home") == @league_statistics.team_goal_stats_averages("away")).to eq(false)

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
  describe '.highest_scoring_visitor' do
    it 'can return the name of the team with the highest average score while visiting' do
      expect(@league_statistics.highest_scoring_visitor).to eq("FC Dallas")
    end
  end
  describe '.highest_scoring_home_team' do
    it 'can return the name of the team with the highest average score while home' do
      expect(@league_statistics.highest_scoring_home_team).to eq("Reign FC")
    end
  end
  describe '.lowest_scoring_visitor' do
    it 'can return the name of the team with the lowest average score while visiting' do
      expect(@league_statistics.lowest_scoring_visitor).to eq("San Jose Earthquakes")
    end
  end
  describe '.lowest_scoring_home_team' do
    it 'can return the name of the team with the lowest average score while home' do
      expect(@league_statistics.lowest_scoring_home_team).to eq("Utah Royals FC")
    end
  end
end
