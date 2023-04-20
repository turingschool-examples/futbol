require 'spec_helper'

RSpec.describe Game do
  before(:each) do
    @game = Futbol.new(CSV.open './spec/fixtures/games.csv', headers: true, header_converters: :symbol)
    @game = Futbol.new(CSV.open './spec/fixtures/game_teams.csv', headers: true, header_converters: :symbol)
    @game_1 = Game.new(id: )
  end

  describe '#initialize' do
    it 'can initialize with attributes' do
      expect(@game).to be_a(Game)
      expect(@game.id).to eq("")
      expect(@game.home_team_id).to eq("")
      expect(@game.away_team_id).to eq("")
      expect(@game.home_team_goals).to eq("")
      expect(@game.away_team_goals).to eq("")
    end
  end
end