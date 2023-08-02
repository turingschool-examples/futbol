# require_relative 'spec_helper'

# RSpec.describe Season do
#   before(:each) do
#     @season = Season.new(20122013, 13, [2222, 333, 444, 555], 3.756)
#   end

#   describe "#initialize" do
#     it 'creates a new instance of season class' do

#       expect(@season).to be_a Season
#     end

#     it 'has readable attributes' do

#       expect(@season.season).to eq(20122013)
#       expect(@season.game_count).to eq(13)
#       expect(@season.games_played).to eq([2222, 333, 444, 555])
#       expect(@season.avg_goals).to eq(3.756)
#       expect(@season.winningest_coach).to be nil
#       expect(@season.worst_coach).to be nil
#       expect(@season.most_accurate_team).to be nil
#       expect(@season.least_accurate_team).to be nil
#       expect(@season.most_tackles).to be nil
#       expect(@season.fewest_tackles).to be nil
#     end
#   end
# end