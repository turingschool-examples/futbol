require_relative './spec_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
end

RSpec.describe StatTracker do
    it 'exists' do
        stat_tracker = StatTracker.new
        expect(stat_tracker).to be_a StatTracker
    end
    before(:each) do
        game_path = './data/games.csv'
        team_path = './data/teams.csv'
        game_teams_path = './data/game_teams.csv'

        @locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
    end

    describe 'Class#from_csv' do
        it 'loads the files from the locations' do
            stat_tracker = StatTracker.from_csv(@locations)
            expect(stat_tracker.games).not_to be_empty
            expect(stat_tracker.teams).not_to be_empty
            expect(stat_tracker.game_teams).not_to be_empty
        end
    end

    describe 'Class#game_factory' do
        it 'creates a game object from a row' do
            game_tracker = StatTracker.game_factory(@locations)

            expect(game_tracker).to include Game
        end

        it 'creates a game object with all attributes' do
            game_tracker = StatTracker.game_factory(@locations)
            
            expect(game_tracker[0].game_id).to eq "2012030221"
            expect(game_tracker[0].season).to eq "20122013"
            expect(game_tracker[0].type).to eq "Postseason"
            expect(game_tracker[0].date_time).to eq "5/16/13"
            expect(game_tracker[0].away_team_id).to eq "3"
            expect(game_tracker[0].home_team_id).to eq "6"
            expect(game_tracker[0].away_goals).to eq 2
            expect(game_tracker[0].home_goals).to eq 3
            expect(game_tracker[0].venue).to eq "Toyota Stadium"
            expect(game_tracker[0].venue_link).to eq "/api/v1/venues/null"
        end
    end

    describe 'Class#team_factory' do
        it 'creates a team object from a row' do
            team_tracker = StatTracker.team_factory(@locations)

            expect(team_tracker).to include Team
        end
    end

    describe 'Class#game_teams_factory' do
        it 'creates a game_teams object from a row' do
            game_teams_tracker = StatTracker.game_team_factory(@locations)

            expect(game_teams_tracker).to include GameTeam
        end
    end
end