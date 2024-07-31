require 'spec_helper'

RSpec.configure do |config| 
    config.formatter = :documentation 
end

RSpec.describe SeasonStatistics do
    it 'exists' do
        expect(SeasonStatistics.new).to be_a SeasonStatistics
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

        @stat_tracker = StatTracker.from_csv(@locations)
    end
    
    it 'can access StatTracker objects' do
        season_statistics = SeasonStatistics.new

        
    end
end