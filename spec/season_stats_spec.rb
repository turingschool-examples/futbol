require 'csv'
require 'simplecov'
require './lib/season_stats'

RSpec.describe Season_stats do
  it 'exists' do
    season_stats = Season_stats.new

    expect(season_stats).to be_an_instance_of(Season_stats)
  end
end
