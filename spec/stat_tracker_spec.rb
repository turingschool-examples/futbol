require 'rspec'
require 'pry'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  it "exists" do
    tracker = StatTracker.new('file_games', 'file_teams', 'file_game_teams')

    expect(tracker).to be_a(StatTracker)
  end

  it "has readable attributes" do
    tracker = StatTracker.new('file_games', 'file_teams', 'file_game_teams')

    expect(tracker.games).to eq('file_games')
    expect(tracker.teams).to eq('file_teams')
    expect(tracker.game_teams).to eq('file_game_teams')
  end
