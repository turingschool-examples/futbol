require './lib/league_statistics'
require 'csv'

RSpec.describe(LeagueStatistics) do
  before :each do
    @league_statistics = LeagueStatistics.new
  end
  it 'exists' do
    expect(@league_statistics).to be_an_instance_of(LeagueStatistics)
  end
end
