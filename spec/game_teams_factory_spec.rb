require './lib/game_teams'
require './lib/game_teams_factory'
require 'pry'

RSpec.describe GameTeamFactory do
    before do
        @file_path = './data/game_teams_fixture.csv'
        @game_team_factory = GameTeamFactory.new(@file_path)
    end

    describe '#initialize' do
        it 'exists' do 
        
            expect(@game_team_factory).to be_a(GameTeamFactory)

        end

        it 'has a file path attribute' do

            expect(@game_team_factory.file_path).to eq(@file_path)

        end
    end

    describe '#create_game_team' do
        it 'creates game team objects from the data stored in its file_path attribute' do

            expect(@game_team_factory.create_game_team).to be_a(Array)
            expect(@game_team_factory.create_game_team.all? {|game_team| game_team.class == GameTeam}).to eq(true)

        end

        it 'creates objects with the necessary attributes' do

            expect(@game_team_factory.create_game_team.first.game_id).to eq(2012030221)
            expect(@game_team_factory.create_game_team.first.team_id).to eq(3)
            expect(@game_team_factory.create_game_team.first.hoa).to eq("away")
            expect(@game_team_factory.create_game_team.first.result).to eq("LOSS")
            expect(@game_team_factory.create_game_team.first.settled_in).to eq("OT")
            expect(@game_team_factory.create_game_team.first.head_coach).to eq("John Tortorella")
            expect(@game_team_factory.create_game_team.first.goals).to eq(2)
            expect(@game_team_factory.create_game_team.first.shots).to eq(8)
            expect(@game_team_factory.create_game_team.first.tackles).to eq(44)
            expect(@game_team_factory.create_game_team.first.pim).to eq(8)
            expect(@game_team_factory.create_game_team.first.power_play_opps).to eq(3)
            expect(@game_team_factory.create_game_team.first.power_play_goals).to eq(0)
            expect(@game_team_factory.create_game_team.first.faceoff_win_percent).to eq(44.8)
            expect(@game_team_factory.create_game_team.first.giveaways).to eq(17)
            expect(@game_team_factory.create_game_team.first.takeaways).to eq(7)

        end
    end
end
