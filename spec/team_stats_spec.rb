require 'csv'
require 'simplecov'
require './lib/team_stats'

RSpec.describe TeamStats do
  it 'exists' do
    team_stats = TeamStats.new

    expect(team_stats).to be_an_instance_of(TeamStats)
  end
end
