require './lib/game_teams'
require 'pry'

RSpec.describe GameTeam do
    describe '#initialize' do

        before do
            
            @game_team_info = { 
                            game_id: 2012030221, team_id: 3, hoa: "away", result: "LOSS", 
                            settled_in: "OT", head_coach: "John Tortorella", goals: 2, shots: 8, 
                            tackles: 44, pim: 8, power_play_opps: 3, power_play_goals: 0, 
                            faceoff_win_percent: 44.8, giveaways: 8, takeaways: 17 
                            }
            
            @game_team = GameTeam.new(@game_team_info)

        end

        it 'exists' do
            
            expect(@game_team).to be_a(GameTeam)

        end

        it 'has a game_id' do

            expect(@game_team.game_id).to eq(2012030221)

        end

        it 'has a team_id' do
            
            expect(@game_team.team_id).to eq(3)

        end

        it 'can return if a team is home or away' do

            expect(@game_team.hoa).to eq("away")

        end

        it 'can return game result' do

            expect(@game_team.result).to eq("LOSS")

        end

        it 'can return how the game was settled' do

            expect(@game_team.settled_in).to eq("OT")

        end

        it 'returns a teams head coach' do

            expect(@game_team.head_coach).to eq("John Tortorella")

        end

        it 'returns goals by specific team in a game' do

            expect(@game_team.goals).to eq(2)

        end

        it 'returns how many shots a team attempted' do

            expect(@game_team.shots).to eq(8)

        end

        it 'returns how many tackles a team made' do

            expect(@game_team.tackles).to eq(44)

        end

        it 'returns pim aka penulty minutes for a team' do

            expect(@game_team.pim).to eq(8)
        
        end

        it 'returns power play opportunities for a team' do
 
            expect(@game_team.power_play_opps).to eq(3)

        end

        it 'returns power play goals for a team' do
            
            expect(@game_team.power_play_goals).to eq(0)

        end

        it 'returns a faceOffWinPercentage float for a team' do
           
            expect(@game_team.faceoff_win_percent).to eq(44.8)

        end

        it 'returns the number of giveaways for a team' do

            expect(@game_team.giveaways).to eq(8)

        end

        it 'returns the number of takeaways for a team' do

            expect(@game_team.takeaways).to eq(17)

        end
    end
end




