require './spec/spec_helper'

RSpec.describe GameTeam do
  before(:each) do
    game_id = 1
    team_id = 2
    goals = 3
    hoa = 'home'
    result = 'WIN'
    tackles = 4
    head_coach = 'Coach'
    shots = 5
    @game_team = GameTeam.new(game_id, team_id, goals, hoa, result, tackles, head_coach, shots)
  end  

  itdescribe 'initialize' do 
    it 'exists' do 
      expect(@game_team).to be_a_instance_of(GameTeam)
    end

    it 'has attributes' do 
      expect(@game_team.game_id).to eq(1)
      expect(@game_team.team_id).to eq(2)
      expect(@game_team.goals).to eq(3)
      expect(@game_team.hoa).to eq('home')
      expect(@game_team.result).to eq('WIN')
      expect(@game_team.tackles).to eq(4)
      expect(@game_team.head_coach).to eq('Coach')
      expect(@game_team.shots).to eq(5)      
    end
  end
end 