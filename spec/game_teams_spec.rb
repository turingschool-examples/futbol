require './lib/game_teams'
require 'pry'

RSpec.describe GameTeams do
    describe '#initialize' do

        before do
            
            @game_teams_info = { 
                            game_id: 2012030221, team_id: 3, HoA: "away", result: "LOSS", 
                            settled_in: "OT", head_coach: "John Tortorella", goals: 2, shots: 8, 
                            tackles: 44, pim: 8, powerPlayOpportunities: 3, powerPlayGoals: 0, 
                            faceOffWinPercentage: 44.8, giveaways: 8, takeaways: 17 
                            }
            
            @game_teams = GameTeams.new(@game_teams_info)

        end

        it 'exists' do
            
            expect(@game_teams).to be_a(GameTeams)

        end

        it 'has a game_id' do

            expect(@game_teams.game_id).to eq(2012030221)

        end

        it 'has a team_id' do
            
            expect(@game_teams.team_id).to eq(3)

        end

        it 'can return if a team is home or away' do

            expect(@game_teams.hoa).to eq("away")

        end

        it 'can return game result' do

            expect(@game_teams.result).to eq("LOSS")

        end

        it 'can return how the game was settled' do

            expect(@game_teams.settled_in).to eq("OT")

        end

        it 'returns a teams head coach' do

            expect(@game_teams.head_coach).to eq("John Tortorella")

        end

        it 'returns goals by specific team in a game' do

            expect(@game_teams.goals).to eq(2)

        end

        it 'returns how many shots a team attempted' do

            expect(@game_teams.shots).to eq(8)

        end

        it 'returns how many tackles a team made' do

            expect(@game_teams.tackles).to eq(44)

        end

        it 'returns pim aka penulty minutes for a team' do

            expect(@game_teams.pim).to eq(8)
        
        end

        it 'returns power play opportunities for a team' do
            #should i keep the method name consistent with the hash key, or change the hash key
            # and the method name to something like power_play_opps?
            expect(@game_teams.powerPlayOpportunities).to eq(3)

        end

        it 'returns power play goals for a team' do
            #same question as above
            expect(@game_teams.powerPlayGoals).to eq(0)

        end

        it 'returns a faceOffWinPercentage float for a team' do
            #same question as above
            expect(@game_teams.faceOffWinPercentage).to eq(44.8)

        end

        it 'returns the number of giveaways for a team' do

            expect(@game_teams.giveaways).to eq(8)

        end

        it 'returns the number of takeaways for a team' do

            expect(@game_teams.takeaways).to eq(17)

        end
    end
end




