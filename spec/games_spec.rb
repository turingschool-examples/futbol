require_relative 'spec_helper'
require './lib/games'

RSpec.describe Games do
    before(:each) do
        @game_objects = []

        #iterate over the csv file to create an array of game objects
        CSV.foreach('./spec/fixtures/fixture_games.csv', headers: true, header_converters: :symbol) do |row|
            @game_objects << Games.new(
              row[:game_id],
              row[:season],
              row[:away_team_id],
              row[:home_team_id],
              row[:away_goals].to_i,
              row[:home_goals].to_i,
            )
        end
    end

    describe '#initialize' do
        it 'exists' do
            #test several elements in the game objects array to ensure they're all instances of Games
            @game_objects.each do |object|
                expect(object).to be_an_instance_of(Games)
            end
        end

        it 'has attributes' do
            expect(@game_objects[0].game_id).to eq("2012030221")
            expect(@game_objects[0].home_team_id).to eq("6")
            expect(@game_objects[1].away_goals).to eq(2)
            expect(@game_objects[1].game_id).to eq("2012030222")
            Games.reset
        end
    end


    describe '#self.load_csv' do 
        it 'creates games from csv' do
            #when given a file pathway string, it will create objects using the data in the csv file'
            game_path = './spec/fixtures/fixture_games.csv'
            games = Games.load_csv(game_path)
            games.each do |game|
                expect(game).to be_an_instance_of(Games)
            end

            expect(games[1].season).to eq("20122013")
            expect(games[0].game_id).to eq("2012030221")
            expect(games[0].home_team_id).to eq("6")
            expect(games[1].away_goals).to eq(2)
            expect(games[1].game_id).to eq("2012030222")
            Games.reset
        end
    end

end
