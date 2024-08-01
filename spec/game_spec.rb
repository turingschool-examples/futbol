require 'spec_helper'

RSpec.describe Game do
    before(:each) do
        @game_path = './data/games.csv'
        @stat_tracker = StatTracker.from_csv(@game_path)
        @games = Game.new(@game_path, @stat_tracker)
    end

    describe '#initialize' do
        it 'can initialize' do
            expect(@game).to be_an_instance_of(Game)
        end

        it 'has a game_id, season, type, and date_time' do
            expect(@game.game_id).to eq()
            expect(@game.season).to eq()
            expect(@game.type).to eq()
            expect(@game.date_time).to eq()
        end

        it 'has a away_team_id and a home_team_id' do
            expect(@game.away_team_id).to eq()
            expect(@game.home_team_id).to eq()
        end

        it 'has a away_goals and a home_goals' do
            expect(@game.away_goals).to eq()
            expect(@game.home_goals).to eq()
        end

        it 'has a venue, venue_link, and a tracker' do
            expect(@game.venue).to eq()
            expect(@game.venue_link).to eq()
            expect(@game.tracker).to eq()
        end
        
    end
end