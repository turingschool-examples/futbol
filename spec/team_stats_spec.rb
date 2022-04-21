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

        @game_team_stats = GameTeamStats.new(@locations)
    end
    
    it 'exists' do 
        expect(@game_team_stats).to be_a(GameTeamStats)
    end

    it '#best_season can determine the best season for a team' do
        expect(@game_team_stats.best_season("24")).to eq("20122013")
    end

    it '#worst_season can determine the best season for a team' do 
    expect(@game_team_stats.worst_season("24")).to eq("20132014")
    end

    it '#average_win_percentage can determine the average wins of all games for a team' do 
        expect(@game_team_stats.average_win_percentage("3")).to eq(0.0)
    end

    it '#most_goals_scored can find the highest number of goals a team has scored in a game' do
        expect(@game_team_stats.most_goals_scored("3")).to eq(2)
    end

    it '#fewest_goals_scored can find the lowest number of goals a team has scored in a game' do 
        expect(@game_team_stats.fewest_goals_scored("3")).to eq(1)
    end 

    it '#favorite_opponent can produce the name of the team with the lowest win percentage against another team' do 
        expect(@game_team_stats.favorite_opponent("24")).to eq("Chicago Fire")
    end

    it '#rival can produce the name that has the highest win percentage against the given team' do
        expect(@game_team_stats.rival("24")).to eq("Portland Timbers")
    end
end