require 'spec_helper'

RSpec.describe LeagueStats do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @league_stats = LeagueStats.new(locations)
  end

  describe '#count_of_teams' do
    it 'counts the number of teams' do
      expect(@league_stats.count_of_teams).to eq(32)
    end
  end

  describe '#best_offense and #worst_offense' do
    it 'calculates the best_offense with the highest number of goals per game' do
      expect(@league_stats.best_offense).to eq('Reign FC')
    end

    it 'calculates the worst_offense with the highest number of goals per game' do
      expect(@league_stats.worst_offense).to eq('Utah Royals FC')
    end
  end

  describe '#Highest and lowest scoring teams' do
    it "shows lowest scoring away team's name across all seasons" do
      expect(@league_stats.lowest_scoring_visitor).to eq('San Jose Earthquakes')
    end

    it "shows highest scoring away team's name across all seasons" do
      expect(@league_stats.highest_scoring_visitor).to eq('FC Dallas')
    end

    it 'returns the home team with the highest score' do
      expect(@league_stats.highest_scoring_home_team).to eq('Reign FC')
    end

    it 'returns the home team with the lowest score' do
      expect(@league_stats.lowest_scoring_home_team).to eq('Utah Royals FC')
    end
  end

  describe '#team_name_by_id' do
    it 'returns the team name by given id' do
      expect(@league_stats.team_name_by_id(1)).to eq('Atlanta United')
    end
  end

  describe '#avg_score_per_game' do
    it 'calculates average number of goals per game' do
      expect(@league_stats.avg_score_per_game([1, 2, 3, 4])).to eq(2.5)
    end
  end
end
