require './lib/stat_tracker'
require "csv"


RSpec.describe 'Stat_Tracker' do
  
  let(:path) { './data/games.csv' }
  let(:path_2) { './data/teams.csv' }
  let(:path_3) { './data/game_teams.csv' }
  
  it 'exists as a csv hash' do

  end

  xit 'can establish data from csv' do
    csv = CSV.parse(File.read('./data/teams.csv'))
    p = StatTracker.new
    p.from_csv(csv)
    expect(p.from_csv(csv)).to be_a(Array)
    expect(p.from_csv(csv)[1]).to be_a(Hash)
  end

  xit 'can sort to which csv method is needed' do
    csv = CSV.parse(File.read('./data/teams.csv'))
    expect(csv[0][1]).to eq("franchiseId")
    csv2 = CSV.parse(File.read('./data/game_teams.csv'))
    expect(csv2[0][1]).to eq("team_id")
  end

  xit 'creates GameFactory with games as a hash' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path)
  end

  xit 'creates TeamFactory with team as a hash' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path_2)
  end

  xit 'creates GameTeamsFactory with game team as a hash' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path_3)
  end

  it 'sums works' do
    stat_tracker = StatTracker.new
    arr = stat_tracker.from_csv(path)
    expect(stat_tracker.highest_sum(arr)).to eq(1262)
    expect(stat_tracker.lowest_sum(arr)).to eq(239)
    stat_tracker.highest_sum(arr) 
    stat_tracker.lowest_sum(arr) 
  end



end