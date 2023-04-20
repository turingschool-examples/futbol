require 'spec_helper'

RSpec.describe Game do
  before(:each) do
#     We were thinking we could add a Futbol class that would act as a "factory" that would open the csv files and generate
#     game and team objects using the game and team classes. 
    
    # @game = Futbol.new(CSV.open './spec/fixtures/games.csv', headers: true, header_converters: :symbol)
    # @game = Futbol.new(CSV.open './spec/fixtures/game_teams.csv', headers: true, header_converters: :symbol)
    @game1 = Game.new(game_id: "5", home_team_id: "1", away_team_id: "2", home_team_goals: "1", away_team_goals: "2")
  end

  describe '#initialize' do
    it 'can initialize with attributes' do
      expect(@game1).to be_a(Game)
      expect(@game1.game_id).to eq("5")
      expect(@game1.away_team_id).to eq("2")
      expect(@game1.home_team_id).to eq("1")
      expect(@game1.home_team_goals).to eq("1")
      expect(@game1.away_team_goals).to eq("2")
    end
  end
end
