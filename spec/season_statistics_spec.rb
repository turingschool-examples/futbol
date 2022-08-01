require 'spec_helper'

RSpec.describe SeasonStatistics do 
  mock_games_data = './data/mock_games.csv' 
  team_data = './data/teams.csv' 
  mock_game_teams_data = './data/mock_game_teams.csv' 
  
  let!(:mock_locations) {{games: mock_games_data, teams: team_data, game_teams: mock_game_teams_data}}

  let!(:season_1) { SeasonStatistics.from_csv(mock_locations) }
  let!(:season_2) { SeasonStatistics.from_csv(mock_locations) }

  context 'season statistics' do 

    it '#winningest_coach' do
      expect(season_1.winningest_coach("20122013")).to eq("Adam Oates")
      expect(season_2.winningest_coach("20152016")).to eq("Lindy Ruff")
    end

    it '#worst_coach' do
      expect(season_1.worst_coach("20122013")).to eq("John Tortorella")
      expect(season_2.worst_coach("20152016")).to eq("Paul Maurice")
    end

    it '#most_accurate_team' do
      expect(season_1.most_accurate_team("20122013")).to eq("Portland Timbers")
      expect(season_2.most_accurate_team("20152016")).to eq("Chicago Red Stars")
    end

    it '#least_accurate_team' do
      expect(season_1.least_accurate_team("20122013")).to eq("Houston Dynamo")
      expect(season_2.least_accurate_team("20152016")).to eq("Portland Thorns FC")
    end

    it '#most_tackles' do
      expect(season_1.most_tackles("20122013")).to eq("Seattle Sounders FC")
      expect(season_2.most_tackles("20152016")).to eq("Chicago Red Stars")
    end

    it '#fewest_tackles' do
      expect(season_1.fewest_tackles("20122013")).to eq("Portland Timbers")
      expect(season_2.fewest_tackles("20152016")).to eq("Portland Thorns FC")
    end
  end
end