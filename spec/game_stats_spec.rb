require 'rspec'
require './lib/game_stats'

RSpec.describe GameStats do
  before(:each) do
    @game_stats = GameStats.new
  end

  it 'exists' do
    expect(@game_stats).to be_a(GameStats)
  end

  xit 'shows highest total score' do
    expect(@game_stats.highest_total_score).to be(11)
  end














end
#
