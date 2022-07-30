require 'spec_helper'

RSpec.describe SeasonStatistics do 
  mock_games_data = './data/mock_games.csv' 
  team_data = './data/teams.csv' 
  mock_game_teams_data = './data/mock_game_teams.csv' 
  
  let!(:mock_locations) {{games: mock_games_data, teams: team_data, game_teams: mock_game_teams_data}}

  let!(:season_1213) { SeasonStatistics.from_csv(mock_locations, "20122013") }
  let!(:season_1516) { SeasonStatistics.from_csv(mock_locations, "20152016") }

  context 'season statistics' do 

    it '#winningest_coach' do
      require 'pry'; binding.pry
      expect(season_1213.winningest_coach).to eq("Adam Oates")
      expect(season_1516.winningest_coach).to eq("Lindy Ruff")
    end

    it '#worst_coach' do
      expect(season_1213.worst_coach).to eq("John Tortorella")
      expect(season_1516.worst_coach).to eq("Paul Maurice")
    end

    it '#most_accurate_team' do
      expect(season_1213.most_accurate_team).to eq("Portland Timbers")
      expect(season_1516.most_accurate_team).to eq("Chicago Red Stars")
    end

    it '#least_accurate_team' do
      expect(season_1213.least_accurate_team).to eq("Houston Dynamo")
      expect(season_1516.least_accurate_team).to eq("Portland Thorns FC")
    end

    it '#most_tackles' do
      expect(season_1213.most_tackles).to eq("Seattle Sounders FC")
      expect(season_1516.most_tackles).to eq("Chicago Red Stars")
    end

    it '#fewest_tackles' do
      expect(season_1213.fewest_tackles).to eq("Portland Timbers")
      expect(season_1516.fewest_tackles).to eq("Portland Thorns FC")
    end

  end
end