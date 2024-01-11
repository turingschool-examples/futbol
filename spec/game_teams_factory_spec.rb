require './lib/game_teams'
require './lib/game_teams_factory'
require 'pry'

RSpec.describe GameTeamsFactory do
    before do
        @file_path = './data/game_teams_fixture.csv'
        @game_teams_factory = GameTeamsFactory.new(@file_path)
    end

    describe '#initialize' do
        it 'exists' do 
        
            expect(@game_teams_factory).to be_a(GameTeamsFactory)

        end

        it 'has a file path attribute' do

            expect(@game_teams_factory.file_path).to eq(@file_path)

        end
    end

    describe '#create_game_teams' do
        it 'creates game teams objects from the data stored in its file_path attribute' do

            expect(@game_teams_factory.create_game_teams).to be_a(Array)
            expect(@game_teams_factory.create_game_teams.all? {|game_teams| game_teams.class == GameTeams}).to eq(true)

        end

        it 'creates objects with the necessary attributes' do

            expect(@game_teams_factory.create_game_teams.first.game_id).to eq(2012030221)
            expect(@game_teams_factory.create_game_teams.first.team_id).to eq(3)
            expect(@game_teams_factory.create_game_teams.first.hoa).to eq("away")
            expect(@game_teams_factory.create_game_teams.first.result).to eq("LOSS")
            expect(@game_teams_factory.create_game_teams.first.settled_in).to eq("OT")
            expect(@game_teams_factory.create_game_teams.first.head_coach).to eq("John Tortorella")
            expect(@game_teams_factory.create_game_teams.first.goals).to eq(2)
            expect(@game_teams_factory.create_game_teams.first.shots).to eq(8)
            expect(@game_teams_factory.create_game_teams.first.tackles).to eq(44)
            expect(@game_teams_factory.create_game_teams.first.pim).to eq(8)
            expect(@game_teams_factory.create_game_teams.first.powerPlayOpportunities).to eq(3)
            expect(@game_teams_factory.create_game_teams.first.powerPlayGoals).to eq(0)
            expect(@game_teams_factory.create_game_teams.first.faceOffWinPercentage).to eq(44.8)
            expect(@game_teams_factory.create_game_teams.first.giveaways).to eq(8)
            expect(@game_teams_factory.create_game_teams.first.takeaways).to eq(17)

        end
    end
end
