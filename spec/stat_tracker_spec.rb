require_relative './spec_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
end

RSpec.describe StatTracker do
    it 'exists' do
        stat_tracker = StatTracker.new
        expect(stat_tracker).to be_a StatTracker
    end

    describe 'Class#from_csv' do
        # takes in a hash of the three data files
        # create instances of teams, games, and game_teams
        # make all of that available to the StatTracker
        it 'loads the files from the locations' do
            game_path = './data/games.csv'
            team_path = './data/teams.csv'
            game_teams_path = './data/game_teams.csv'

            locations = {
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path
            }
            stat_tracker = StatTracker.from_csv(locations)
            expect(stat_tracker.games).not_to be_empty
            expect(stat_tracker.teams).not_to be_empty
            expect(stat_tracker.game_teams).not_to be_empty
        end
    end

    describe 'Class#game_factory' do
        it 'creates a game object from a row' do
        end
    end

    describe 'Class#team_factory' do
        it 'creates a team object from a row' do
        end
    end

    describe 'Class#game_teams_factory' do
        it 'creates a game_teams object from a row' do
        end
    end
end