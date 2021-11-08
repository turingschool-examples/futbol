require 'csv'
require 'simplecov'
require './lib/game_stats'

SimpleCov.start

RSpec.describe GameStats do
  before :each do
    @game_path = './data/games.csv'
    @rows = CSV.read(@game_path, headers: true)
    @row = @rows[1]
    @game_stats = GameStats.new(@row)
  end
  it 'exists' do

    expect(@game_stats).to be_an_instance_of(GameStats)
  end
end 

#   it "#highest_total_score" do
#
#     expect(@game_stats.highest_total_score).to eq(5)
#   end
#
#   xit "lowest_total_score" do
#
#     expect(@game_stats.lowest_total_score).to eq(0)
#   end
#
#   xit "#percentage_home_wins" do
#
#     expect(@game_stats.percentage_home_wins).to eq(55.56)
#   end
#
#   xit "#percentage_away_wins" do
#
#     expect(@game_stats.percentage_away_wins).to eq(33.33)
#   end
#
#   xit "#percentage_ties" do
#
#     expect(@game_stats.percentage_ties).to eq(11.11)
#   end
#
#   xit "count_of_games_by_season" do
#
#     expect(@game_stats.count_of_games_by_season).to eq(Hash)
#   end
#
#
# end
