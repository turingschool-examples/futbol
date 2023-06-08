require './lib/stat_tracker'
require "csv"
require 'spec_helper'

RSpec.describe 'Stat_Tracker' do
  
  let(:path) { './data/games.csv' }
  let(:path_2) { './data/teams.csv' }
  let(:path_3) { './data/game_teams.csv' }


  it 'creates GameFactory with games as a hash' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path)
  end

  it 'creates TeamFactory with team as a hash' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path_2)
  end

  it 'creates GameTeamsFactory with game team as a hash' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path_3)
  end

end