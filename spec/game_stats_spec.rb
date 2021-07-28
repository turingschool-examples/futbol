require 'rspec'
require './lib/game_stats'
require './lib/stat_tracker'
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

  it 'gives percentage of home wins' do
    expect(@game_stats.percentage_home_wins).to be_a(Float)
  end

  it 'gives percentage of visitor wins' do
    expect(@game_stats.percentage_visitor_wins).to be_a(Float)
  end

  it 'can give percentage of ties' do
    expect(@game_stats.percentage_ties).to be_a(Float)
  end

  it 'gives correct results for win/tie percentages' do
    expect(@game_stats.percentage_home_wins + @game_stats.percentage_visitor_wins + @game_stats.percentage_ties).to eq(1.0)
  end

  it 'can give count of games by season' do
    require 'pry'; binding.pry
    expect(@game_stats.count_of_games_by_season).to be_a(Hash)
  end

  it 'gives average goals per game' do
    expect(@game_stats.average_goals_per_game).to be_a(Float)
  end

  xit 'gives average goals by season' do
    expect(@game_stats.average_goals_by_season).to be_a(Hash)
  end
end
