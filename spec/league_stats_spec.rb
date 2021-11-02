require 'csv'
require 'simplecov'
require './lib/league_stats'

RSpec.describe LeagueStats do
  it 'exists' do
    league_stats = LeagueStats.new

    expect(league_stats).to be_an_instance_of(LeagueStats)
  end
end
