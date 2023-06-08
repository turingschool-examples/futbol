require 'spec_helper'
require './lib/game_stats'

RSpec.describe GameStats do

  it "can find the percentage of games that resulted in a tie" do
    game_stats = GameStats.new
    expect(game_stats.percent_of_ties).to eq(0.2)
  end
end
