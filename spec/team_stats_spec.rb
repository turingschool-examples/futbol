require 'csv'
require 'simplecov'
require './lib/team_stats'

RSpec.describe Team_stats do
  it 'exists' do
    team_stats = Team_stats.new

    expect(team_stats).to be_an_instance_of(Team_stats)
  end
end
