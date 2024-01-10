require './spec/spec_helper.rb'

RSpec.describe GameStatistics do 
    describe '#initialize' do 
        it 'exists' do 
            game_stats = GameStatistics.new

            expect(game_stats).to be_a GameStatistics
        end
    end

    describe '#create_game_stats(filepath)' do 
        it 'it has a access to the data from the file path' do 
            game_stats = GameStatistics.new

            expect(game_stats.create_game_stats('./data/games_sample.csv')).to be_a Array
            expect(game_stats.create_game_stats('./data/games_sample.csv').first.game_id).to eq(2012030221)
            expect(game_stats.create_game_stats('./data/games_sample.csv').first.season).to eq(20122013)
            expect(game_stats.create_game_stats('./data/games_sample.csv').first.away_team_id).to eq('3')
            expect(game_stats.create_game_stats('./data/games_sample.csv').first.home_team_id).to eq('6')
            expect(game_stats.create_game_stats('./data/games_sample.csv').first.away_goals).to eq(2)
            expect(game_stats.create_game_stats('./data/games_sample.csv').first.home_goals).to eq(3)   
        end
    end

   
end
