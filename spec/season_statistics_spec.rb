require 'spec_helper'

RSpec.describe SeasonStatistics do 
  team_data = CSV.read './data/teams.csv', headers:true, header_converters: :symbol
  mock_game_teams_data = CSV.read './data/mock_game_teams.csv', headers: true, header_converters: :symbol
  let!(:league_statistics) { LeagueStatistics.new(team_data, mock_game_teams_data) }
  mock_games_data = CSV.read './data/mock_games.csv', headers: true, header_converters: :symbol
  

  let!(:season) { SeasonStatistics.new(team_data, mock_games_data, mock_game_teams_data) }

  context 'season statistics' do 

    it '#winningest_coach' do
      expect(season.winningest_coach("20122013")).to eq("Adam Oates")
      expect(season.winningest_coach("20152016")).to eq("Lindy Ruff")
    end

    it '#worst_coach' do
      expect(season.worst_coach("20122013")).to eq("John Tortorella")
      expect(season.worst_coach("20152016")).to eq("Paul Maurice")
    end

    it '#most_accurate_team' do
      expect(season.most_accurate_team("20122013")).to eq("Portland Timbers")
      expect(season.most_accurate_team("20152016")).to eq("Chicago Red Stars")
    end

    it '#least_accurate_team' do
      expect(season.least_accurate_team("20122013")).to eq("Houston Dynamo")
      expect(season.least_accurate_team("20152016")).to eq("Portland Thorns FC")
    end

    it '#most_tackles' do
      expect(season.most_tackles("20122013")).to eq("Seattle Sounders FC")
      expect(season.most_tackles("20152016")).to eq("Chicago Red Stars")
    end

    it '#fewest_tackles' do
      expect(season.fewest_tackles("20122013")).to eq("Portland Timbers")
      expect(season.fewest_tackles("20152016")).to eq("Portland Thorns FC")
    end
  end
end