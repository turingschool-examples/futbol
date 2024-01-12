require "./spec/spec_helper"

RSpec.describe StatTracker do
    it 'exists' do
        game_path = './data/games.csv'
        team_path = './data/teams.csv'
        game_teams_path = './data/game_teams.csv'

        locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }

        stat_tracker = StatTracker.new(locations)
        expect(stat_tracker).to be_an_instance_of(StatTracker)
        # expect(stat_tracker.game).to be_an_instance_of(Game)
    end

    it 'can create objects' do
        #code
    end

    it 'highest total score game' do
        game_path = './spec/fixtures/games_fixture.csv'
        #this is looking at the original teams.csv file rn
        team_path = './data/teams.csv'
        game_teams_path = './spec/fixtures/game_teams_fixture.csv'

        locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }

        stat_tracker = StatTracker.new(locations)
        # StatTracker.from_csv(locations)
        expect(stat_tracker.highest_total_score).to eq(5)
    end
end