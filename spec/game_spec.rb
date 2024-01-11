require 'spec_helper'
require 'simplecov'

RSpec.describe Game do
   before(:each) do
   @games = []
      CSV.foreach('data/games_fixture.csv', headers: true, header_converters: :symbol) do |row|
         game_details = {
         game_id: row[:game_id],
         season: row[:season],
         away_team_id: row[:away_team_id],
         home_team_id: row[:home_team_id],
         away_goals: row[:away_goals],
         home_goals: row[:home_goals]
         }
         @games << Game.new(game_details)
      end
      @games
   end

   describe '#initialize' do
      before(:each) do
         @game_1 = @games[0]
         @game_2 = @games[-1]
         #require 'pry'; binding.pry
      end

      it 'exists' do
         expect(@game_1).to be_a Game
      end

      it 'has a game id' do
         expect(@game_1.game_id).to eq("2012030221")
         
         expect(@game_2.game_id).to eq("2012030124")
      end
      
      it "has a season" do
         expect(@game_1.season).to eq("20122013")
         
         expect(@game_2.season).to eq("20122013")
      end

      it "has different home and away team id" do
         expect(@game_1.away_team_id).to eq(3)
         expect(@game_1.home_team_id).to eq(6)
         
         expect(@game_2.home_team_id).to eq(9)
         expect(@game_2.away_team_id).to eq(8)
      end

      it "can identify home and away goals" do
         expect(@game_1.away_goals).to eq(2)
         expect(@game_1.home_goals).to eq(3)

         expect(@game_2.away_goals).to eq(2)
         expect(@game_2.home_goals).to eq(3)
      end
   end
end