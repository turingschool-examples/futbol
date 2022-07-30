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
  describe '.total_team_goal_stats' do
    it 'can return a hash of total games, total goals, home games, and away games by team id' do
      game_count_54 = 0
      @data_set.data[:game_teams].each do |row|
        if row[:team_id] == "54"
          game_count_54 += 1
        end
      end

      expect(@league_statistics.total_team_goal_stats).to be_a(Hash)
      expect(@league_statistics.total_team_goal_stats["54"][0]).to eq(game_count_54)
      expect(@league_statistics.total_team_goal_stats["54"][2] + @league_statistics.total_team_goal_stats["54"][3]).to eq(game_count_54)
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
