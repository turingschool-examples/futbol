require './lib/stat_tracker.rb'
require './spec/spec_helper.rb'
require './lib/game_statistics'
require 'pry'

RSpec.describe GameStatistics do
  files = {game_stats: './data/dummy_game_teams.csv',
          games: './data/dummy_games.csv',
          teams: './data/dummy_teams.csv'}
  subject {GameStatistics.new(files)}

  it "exists" do
    expect(subject).to be_a GameStatistics
  end

  it "displays #highest total score of a game" do
    expect(subject.highest_total_score).to eq(6)
  end

  it "displays #lowest total score of a game" do
    expect(subject.lowest_total_score).to eq(1)
  end
end
