require 'spec_helper'

RSpec.describe StatTracker do
    before do 
        @stat_tracker_1 = StatTracker.new
    end

    describe '#initialize' do
        it 'exists' do
            expect(@stat_tracker_1).to be_a(StatTracker)
        end

        it 'starts with empty attributes' do
            expect(@stat_tracker_1.game_path).to eq('')
            expect(@stat_tracker_1.team_path).to eq('')
            expect(@stat_tracker_1.game_teams_path).to eq('')
        end
    end
    
    before do
        @game_path = './data/game_fixture.csv'
        @team_path = './data/teams_fixture.csv'
        @game_teams_path = './data/game_teams_fixture.csv'
        @locations = { games: @game_path, teams: @team_path, game_teams: @game_teams_path }

        @stat_tracker_2 = StatTracker.from_csv(@locations)
    end

    describe '#from_csv' do
        it 'will set the file paths for game, team, and game_teams atrributes and return a new instance of stat_tracker' do
            expect(StatTracker.from_csv(@locations)).to be_a(StatTracker)
            expect(@stat_tracker_2.game_path).to eq(@game_path)
            expect(@stat_tracker_2.team_path).to eq(@team_path)
            expect(@stat_tracker_2.game_teams_path).to eq(@game_teams_path)
        end
    end

    describe '#make_factories' do
        it 'creates the factories for game, team, and game_team classes' do
            @stat_tracker_2.make_factories

            expect(@stat_tracker_2.game_factory).to be_a(GameFactory)
            expect(@stat_tracker_2.team_factory).to be_a(TeamFactory)
            expect(@stat_tracker_2.game_teams_factory).to be_a(GameTeamFactory)
        end
    end

    describe '#use_factories' do
        it 'will make its factories read their data and create instances of their objects' do
            @stat_tracker_2.make_factories
            @stat_tracker_2.use_factories

            expect(@stat_tracker_2.game_factory.games.all?{|game| game.class == Game}).to eq(true)
            expect(@stat_tracker_2.team_factory.teams.all?{|team| team.class == Team}).to eq(true)
            expect(@stat_tracker_2.game_teams_factory.game_teams.all?{|game_teams| game_teams.class == GameTeam}).to eq(true)
        end
    end
    
end