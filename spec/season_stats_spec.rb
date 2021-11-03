require 'csv'
require 'simplecov'
require './lib/season_stats'

RSpec.describe SeasonStats do
  it 'exists' do
    season_stats = SeasonStats.new

    expect(season_stats).to be_an_instance_of(SeasonStats)
  end
end
