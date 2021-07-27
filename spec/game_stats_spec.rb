require 'rspec'
require './lib/game_stats'
require './lib/stattracker'
require './lib/games'

RSpec.describe GameStats do
  before(:each) do
    game_file = Games.file('./data/games.csv')
    @game_stats = GameStats.new(game_file)
  end

  it 'exists' do
    expect(@game_stats).to be_a(GameStats)
  end

  it 'gives highest total score' do
    expect(@game_stats.highest_total_score).to be(11)
  end

  it 'gives lowest total score' do
    expect(@game_stats.lowest_total_score).to be(0)
  end

  xit 'gives percentage of home wins' do
    expect(@game_stats.percentage_home_wins).to be_a(Float)
  end

  xit 'gives percentage of visitor wins' do
    expect(@game_stats.percentage_visitor_wins).to be_a(Float)
  end

  xit 'can give percentage of ties' do
    expect(@game_stats.percenatage_ties).to eq(Float)
  end

  xit 'can give count of games by season' do
    expect(@game_stats.count_of_games_by_season).to eq(Hash)
  end

  xit 'gives average goals per game' do
    expect(@game_stats.average_goals_per_game).to be(Float)
  end

  xit 'gives average goals by season' do
    expect(@game_stats.average_goals_by_season).to be(Hash)
  end
end
