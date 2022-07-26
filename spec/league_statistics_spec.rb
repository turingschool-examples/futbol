require './lib/league_statistics'
require 'csv'
require 'pry'

RSpec.describe(LeagueStatistics) do
  before :each do
    @data = CSV.open "data/dummy_game_teams.csv", headers: true
    @league_statistics = LeagueStatistics.new(@data)
  end
  it 'exists' do
    expect(@league_statistics).to be_an_instance_of(LeagueStatistics)
  end
  it 'has a CSV data set' do
    expect(@league_statistics.data_set).to be_a(CSV)
    expect(@league_statistics.data_set).to eq(@data)
  end
  it 'has a count of teams' do
    expect(@league_statistics.count_of_teams).to eq(11)
  end
end
