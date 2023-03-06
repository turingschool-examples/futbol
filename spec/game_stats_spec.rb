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

  describe 'highest and lowest total scores' do
    it "#highest_total_score" do

      expect(@game_stats.highest_total_score).to eq(11)
    end
  
    it "#lowest_total_score" do
      expect(@game_stats.lowest_total_score).to eq(0)
    end
  end

  describe '#percentage_wins' do
    it 'calculates the percentage of wins for all teams playing home games' do
      expect(@game_stats.percentage_home_wins).to eq(0.44)
    end

    it 'calculates the percentage of wins for all teams playing away games' do
      expect(@game_stats.percentage_visitor_wins).to eq(0.36)
    end

    it 'calculates the percentage of ties for all teams across all seasons' do
      expect(@game_stats.percentage_ties).to eq(0.20)
    end
  end

  describe '#counts_games_by_season' do
    it 'counts games by season' do
      expect(@game_stats.count_of_games_by_season).to be_a(Hash)

      expected = {
        '20122013' => 806,
        '20132014' => 1323,
        '20142015' => 1319,
        '20152016' => 1321,
        '20162017' => 1317,
        '20172018' => 1355
      }

      expect(@game_stats.count_of_games_by_season).to eq(expected)
    end
  end

  describe '#average_goals_by_season' do
    it 'returns a hash of season keys and average goals value' do
      expected = {
        '20122013' => 4.12,
        '20162017' => 4.23,
        '20142015' => 4.14,
        '20152016' => 4.16,
        '20132014' => 4.19,
        '20172018' => 4.44
      }

      expect(@game_stats.average_goals_by_season).to eq(expected)
    end
  end
end