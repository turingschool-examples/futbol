require './lib/game_team_stats'
require './lib/stat_tracker'
require './lib/csv_reader'

RSpec.describe GameTeamStats do 
    before :each do
        @game_path = './data/dummy_games.csv'
        @team_path = './data/teams.csv'
        @game_teams_path = './data/dummy_game_teams.csv'
        
        @locations = {
          games: @game_path,
          teams: @team_path,
          game_teams: @game_teams_path
        }

        @game_team_stats = GameTeamStats.new
        @csv_reader = CSVReader.new(@locations)
    end
    
    it 'exists' do 
        # require 'pry'; binding.pry
        expect(@game_team_stats).to be_a(GameTeamStats)
    end

    it '#best_season can determine the best season for a team' do
        expect(@game_team_stats.best_season("24")).to eq("20122013")
    end

    it '#worst_season can determine the best season for a team' do 
    expect(@game_team_stats.worst_season("24")).to eq("20132014")
    end
end