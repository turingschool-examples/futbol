require './lib/stat_tracker'
require "csv"


RSpec.describe 'Stat_Tracker' do
  it 'exists as a csv hash' do
    csv = CSV.parse(File.read('./data/teams.csv'))
    require 'pry'; binding.pry
    expect(csv).to be_a(Array)

  end

  it 'can establish data from csv' do
    csv = CSV.parse(File.read('./data/teams.csv'))
    p = StatTracker.new
    p.from_csv(csv)
    expect(p.from_csv(csv)).to be_a(Array)
    expect(p.from_csv(csv)[1]).to be_a(Hash)
  end

  it 'can sort to which csv method is needed' do
    csv = CSV.parse(File.read('./data/teams.csv'))
    expect(csv[0][1]).to eq("franchiseId")
    csv2 = CSV.parse(File.read('./data/game_teams.csv'))
    expect(csv2[0][1]).to eq("team_id")
  end


end