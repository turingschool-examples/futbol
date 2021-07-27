require "simplecov"
require "CSV"
require "./lib/stat_tracker"
require "./lib/league"


SimpleCov.start
RSpec.describe League do
  # before(:each) do

  it 'exists and can read data' do
    league = League.new([], [], [])

    expect(league).to be_a(League)
    expect(league.games).to eq([])
    expect(league.teams).to eq([])
    expect(league.game_teams).to eq([])
  end

  it 'can count numbers of teams' do
    team = [{}, {}, {}, {}, {}]
    league = League.new([], team, [])

    expect(league.count_of_teams).to eq(5)
  end

end
