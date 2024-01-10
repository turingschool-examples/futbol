require './spec/spec_helper.rb'

RSpec.describe Game do 
    describe '#initialize' do
        it 'exists' do 
            game = Game.new({
                game_id: '2012030221',
                season: '20122013',
                type: 'Postseason',
                away_team_id: 3, 
                home_team_id: 6, 
                away_goals: '2',
                home_goals: '3'})

            expect(game).to be_a Game
        end 
    end
end