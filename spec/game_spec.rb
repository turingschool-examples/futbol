require 'spec_helper'
require 'rspec'
require 'csv'

RSpec.describe Game do
   before(:all) do
      @games = []
      CSV.foreach('./data/games.csv', headers: true) do |row|
        p row
        @games << Game.new(row)
      end
   end

   describe 'Game instance' do
      it 'exists' do
        expect(@games.first).to be_an_instance_of(Game)
      end

      it 'has correct attributes' do
        game = @games.first
        expect(game.game_id).to eq('2012030221')
      expect(game.season).to eq('20122013')
      expect(game.type).to eq('Postseason')
      expect(game.date_time).to eq('2013-05-16')
      expect(game.away_team_id).to eq('3')
      expect(game.home_team_id).to eq('6')
      expect(game.away_goals).to eq('2')
      expect(game.home_goals).to eq('3')
      expect(game.venue).to eq('Toyota Stadium')
      expect(game.venue_link).to eq('/api/v1/venues/null')
      end
   end
end