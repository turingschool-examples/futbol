require 'spec_helper'

RSpec.describe GameTeam do
  before(:each) do
    stats =  {
      :game_id => "2012030221",
      :team_id => "3",
      :hoa => "away",
      :result => "LOSS",
      :settled_in => "OT",
      :head_coach => "John Tortorella",
      :goals => "2",
      :shots => "8",
      :tackles => "44",
      :pim => "8",
      :power_play_opportunities =>"3",
      :power_play_goals =>"0",
      :face_off_win_percentage =>"44",
      :giveaways => "17",
      :takeaways => "7"
    }
    @game_team = GameTeam.new(stats)
  end

  describe '#initialize' do 
    it 'exists' do 
      expect(@game_team).to be_a GameTeam
    end

    it 'has attributes' do 
      expect(@game_team.game_id).to eq('2012030221')
      expect(@game_team.team_id).to eq('3')
      expect(@game_team.hoa).to eq('away')
      expect(@game_team.result).to eq('LOSS')
      expect(@game_team.settled_in).to eq('OT')
      expect(@game_team.head_coach).to eq('John Tortorella')
      expect(@game_team.goals).to eq(2)
      expect(@game_team.shots).to eq(8)
      expect(@game_team.tackles).to eq(44)
      expect(@game_team.pim).to eq(8)
      expect(@game_team.power_play_opportunities).to eq(3)
      expect(@game_team.power_play_goals).to eq(0)
      expect(@game_team.face_off_win_percentage).to eq(44)
      expect(@game_team.giveaways).to eq(17)
      expect(@game_team.takeaways).to eq(7)
    end

    it 'begins without a season' do 
      expect(@game_team.season).to be nil
    end

    it 'can be given a season' do 
      @game_team.season = '20122013'
      expect(@game_team.season)
    end
  end
end