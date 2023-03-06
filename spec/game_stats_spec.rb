require 'spec_helper'

RSpec.describe GameStats do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @game_stats = GameStats.new(locations)
  end

  describe '#games_by_season' do
    it 'games by season' do
      expect(@game_stats.games_by_season).to be_a(Hash)
    end
  end

  describe '#team_name_by_id' do
    it 'returns the team name by given id' do
      expect(@game_stats.team_name_by_id(1)).to eq('Atlanta United')
    end
  end

  describe'#avg_score_per_game' do
    it 'calculates average number of goals per game' do
      expect(@game_stats.avg_score_per_game([1,2,3,4])).to eq(2.5)
    end
  end

  describe 'highest and lowest total scores' do
    it "#highest_total_score" do

      expect(@game_stats.highest_total_score).to eq(11)
    end
  
    it "#lowest_total_score" do
      expect(@game_stats.lowest_total_score).to eq(0)
    end
  end

  describe '#highest_scoring_home_team and #lowest_scoring_home_team' do
    it 'returns the home team with the highest score' do
      expect(@game_stats.highest_scoring_home_team).to eq('Reign FC')
    end

    it 'returns the home team with the lowest score' do
      expect(@game_stats.lowest_scoring_home_team).to eq('Utah Royals FC')
    end
  end

  describe '#Highest and lowest scoring teams' do
    it "shows lowest scoring away team's name across all seasons" do
      expect(@game_stats.lowest_scoring_visitor).to eq("San Jose Earthquakes")
    end
    
    it "shows highest scoring away team's name across all seasons" do
      expect(@game_stats.highest_scoring_visitor).to eq("FC Dallas")
    end
  end
end