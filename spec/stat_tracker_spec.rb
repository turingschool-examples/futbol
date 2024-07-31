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
        game_path = './data/dummy_games.csv'
        team_path = './data/dummy_teams.csv'
        game_teams_path = './data/dummy_game_teams.csv'

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

        it 'creates a team object with all variables filled' do
            team_tracker = StatTracker.team_factory(@locations)

            expect(team_tracker[0].team_id).to eq "1"
            expect(team_tracker[0].franchise_id).to eq "23"
            expect(team_tracker[0].team_name).to eq "Atlanta United"
            expect(team_tracker[0].abbreviation).to eq "ATL"
            expect(team_tracker[0].stadium).to eq "Mercedes-Benz Stadium"
            expect(team_tracker[0].link).to eq "/api/v1/teams/1"
        end
    end

    describe 'Class#game_teams_factory' do
        it 'creates a game_teams object from a row' do
            game_teams_tracker = StatTracker.game_team_factory(@locations)

            expect(game_teams_tracker).to include GameTeam
        end

        it 'creates a game_teams object with all variables filled' do
            game_teams_tracker = StatTracker.game_team_factory(@locations)
            expect(game_teams_tracker[0].game_id).to eq "2012030221"
            expect(game_teams_tracker[0].team_id).to eq "3"
            expect(game_teams_tracker[0].hoa).to eq "away"
            expect(game_teams_tracker[0].result).to eq "LOSS"
            expect(game_teams_tracker[0].settled_in).to eq "OT"
            expect(game_teams_tracker[0].head_coach).to eq "John Tortorella"
            expect(game_teams_tracker[0].goals).to eq 2
            expect(game_teams_tracker[0].shots).to eq 8
            expect(game_teams_tracker[0].tackles).to eq 44
            expect(game_teams_tracker[0].pim).to eq 8
            expect(game_teams_tracker[0].power_play_opportunities).to eq 3
            expect(game_teams_tracker[0].power_play_goals).to eq 0
            expect(game_teams_tracker[0].face_off_win_percentage).to eq 44.8
            expect(game_teams_tracker[0].giveaways).to eq 17
            expect(game_teams_tracker[0].takeaways).to eq 7
        end
    end
end