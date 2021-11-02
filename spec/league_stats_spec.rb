require 'csv'
require 'simplecov'
require './lib/league_stats'

RSpec.describe League_stats do
  it 'exists' do
    league_stats = League_stats.new

    expect(league_stats).to be_an_instance_of(League_stats)
  end
end
