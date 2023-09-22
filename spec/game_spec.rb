require './spec/spec_helper'

RSpec.describe Game do
  before(:each) do
    game_id = 1
    season = '2012'
    away_goals = 3
    home_goals = 4
    away_team_id = '5'
    home_team_id = 6
    @game = Game.new(game_id,season, away_goals, home_goals, away_team_id, home_team_id)
  end  

  describe 'initialize' do 
    it 'exists' do 
      expect(@game).to be_a_instance_of(Game)
    end

    it 'has attributes' do 
      expect(@game.game_id).to eq(1)
      expect(@game.season).to eq('2012')
      expect(@game.away_goals).to eq(3)
      expect(@game.home_goals).to eq(4)
      expect(@game.away_team_id).to eq('5')
      expect(@game.home_team_id).to eq('6')
    end
  end
end 