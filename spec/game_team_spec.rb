require 'spec_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
end

RSpec.describe GameTeam do 
  before(:each) do 
    class_info = {:game_id => "2012030221",
    :team_id => "3",
    :hoa => "away",
    :result => "LOSS",
    :settled_in => "OT",
    :head_coach => "John Tortorella",
    :goals => "2",
    :shots => "8",
    :tackles => "44",
    :pim => "8",
    :power_play_opportunities => "3",
    :power_play_goals => "0",
    :face_off_win_percentage => "44.8",
    :giveaways => "17",
    :takeaways => "7"}

    @game_teams_data = GameTeam.new(class_info)
   end
 
   describe '#initialize' do
     it 'exists' do
       expect(@game_teams_data).to be_an_instance_of(GameTeam)
     end
 
     it 'has attributes' do
       expect(@game_teams_data.game_id).to eq("2012030221")
       expect(@game_teams_data.team_id).to eq("3")
       expect(@game_teams_data.hoa).to eq("away")
       expect(@game_teams_data.result).to eq("LOSS")
       expect(@game_teams_data.settled_in).to eq("OT")
       expect(@game_teams_data.head_coach).to eq("John Tortorella")
     end

     it 'converts strings to integers' do
       expect(@game_teams_data.goals).to be_a Integer 
       expect(@game_teams_data.goals).to eq(2)
       expect(@game_teams_data.shots).to be_a Integer
       expect(@game_teams_data.shots).to eq(8)

       expect(@game_teams_data.tackles).to be_a Integer
       expect(@game_teams_data.tackles).to eq(44)
       expect(@game_teams_data.pim).to be_a Integer
       expect(@game_teams_data.pim).to eq(8)

       expect(@game_teams_data.power_play_opportunities).to be_a Integer
       expect(@game_teams_data.power_play_opportunities).to eq(3)
       expect(@game_teams_data.power_play_goals).to be_a Integer
       expect(@game_teams_data.power_play_goals).to eq(0)

       expect(@game_teams_data.giveaways).to be_a Integer
       expect(@game_teams_data.giveaways).to eq(17)
       expect(@game_teams_data.takeaways).to be_a Integer
       expect(@game_teams_data.takeaways).to eq(7)
     end

     it 'converts the percentage to a float' do
      expect(@game_teams_data.face_off_win_percentage).to be_a Float
      expect(@game_teams_data.face_off_win_percentage).to eq(44.8)
     end
   end
 end