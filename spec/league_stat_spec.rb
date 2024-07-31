require 'spec_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
end

RSpec.describe LeagueStatistics do
    it 'exists' do
        league_statistics = LeagueStatistics.new

        expect(LeagueStatistics.new).to be_a LeagueStatistics
    end

    before(:each) do
        game_path = './data/dummy_games.csv'
        team_path = './data/dummy_teams.csv'
        game_teams_path = './data/dummy_game_teams.csv'

        @locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }

    end

    it 'can access StatTracker objects' do
        league_statistics = LeagueStatistics.new
        
    
    end
end
