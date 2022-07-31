require 'csv'
require_relative './game_statistics'
require_relative './game_stat_module'

RSpec.describe class GameStatistics do
  mock_games_data = './data/mock_games.csv' 
  team_data = './data/teams.csv' 
  mock_game_teams_data = './data/mock_game_teams.csv' 
  
  # let!(:mock_locations) {{games: mock_games_data, teams: team_data, game_teams: mock_game_teams_data}}

  let!(:stat_tracker) { StatTracker.from_csv(mock_locations) }
  
  context 'stat_tracker instantiates' do
    it 'should have a class' do
      expect(stat_tracker).to be_a StatTracker
    end

    it 'self method should be an instance of the class' do
      expect(StatTracker.from_csv(mock_locations)).to be_a StatTracker
    end
  end

  context 'game statistics' do

    it '#highest_total_score' do
      expect(stat_tracker.highest_total_score).to eq 9
    end

    it "#lowest_total_score" do
      expect(stat_tracker.lowest_total_score).to eq 1
    end

    it "#percentage_home_wins" do
      expect(stat_tracker.percentage_home_wins).to eq 0.57
    end

    it '#percentage_visitor_wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq 0.36
    end

    it '#percentage_ties' do
      expect(stat_tracker.percentage_ties).to eq 0.09
    end

    it '#count_of_games_by_season' do
      expected = {
      "20122013"=>36, 
      "20132014"=>13, 
      "20142015"=>18, 
      "20152016"=>41, 
      "20162017"=>16, 
      "20172018"=>24
      }
      expect(stat_tracker.count_of_games_by_season).to eq expected
    end

    it '#average_goals_per_game' do
      expect(stat_tracker.average_goals_per_game).to eq 4.09
    end

    it '#average_goals_by_season' do
      expected = {
      "20122013"=>3.92, 
      "20132014"=>4.15, 
      "20142015"=>3.89, 
      "20152016"=>4.02, 
      "20162017"=>4.56, 
      "20172018"=>4.29
      }
      expect(stat_tracker.average_goals_by_season).to eq expected
    end
  end