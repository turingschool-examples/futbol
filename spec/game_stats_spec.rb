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
end