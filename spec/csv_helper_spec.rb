require './spec/spec_helper'


describe CSVHelper do
    describe '#self.teamsCSV' do
        it 'can parse teams.csv' do
            teams = CSVHelper.teamsCSV('./data/teams.csv')

            expect(teams[0].team_id).to eq 1
            expect(teams[0].franchise_id).to eq 23
            expect(teams[0].team_name).to eq "Atlanta United"
            expect(teams[0].abbreviation).to eq "ATL"
            expect(teams[0].stadium).to eq "Mercedes-Benz Stadium"
            expect(teams[0].link).to eq "/api/v1/teams/1"
        end
    end

    describe '#self.gamesCSV' do
        it 'can parse games.csv' do
            games = CSVHelper.gamesCSV('./data/games.csv')

            expect(games[0].game_id).to eq 2012030221
            expect(games[0].season).to eq 20122013
            expect(games[0].type).to eq "Postseason"
            expect(games[0].date_time).to eq "5/16/13"
            expect(games[0].away_team_id).to eq 3
            expect(games[0].home_team_id).to eq 6
            expect(games[0].away_goals).to eq 2
            expect(games[0].home_goals).to eq 3
            expect(games[0].venue).to eq "Toyota Stadium"
            expect(games[0].venue_link).to eq "/api/v1/venues/null"
        end
    end

    describe '#self.game_teams' do
        it 'can parse game_teams.csv' do
            game_teams = CSVHelper.game_teamsCSV('./data/game_teams.csv')

            expect(game_teams[0].game_id).to eq 2012030221
            expect(game_teams[0].team_id).to eq 3
            expect(game_teams[0].hoa).to eq "away"
            expect(game_teams[0].result).to eq "LOSS"
            expect(game_teams[0].settled_in).to eq "OT"
            expect(game_teams[0].head_coach).to eq "John Tortorella"
            expect(game_teams[0].goals).to eq 2
            expect(game_teams[0].shots).to eq 8
            expect(game_teams[0].tackles).to eq 44
            expect(game_teams[0].pim).to eq 8
            expect(game_teams[0].power_play_opportunities).to eq 3
            expect(game_teams[0].power_play_goals).to eq 0
            expect(game_teams[0].face_off_win_percentage).to eq 44.8
            expect(game_teams[0].giveaways).to eq 17
            expect(game_teams[0].takeaways).to eq 7
        end
    end
end