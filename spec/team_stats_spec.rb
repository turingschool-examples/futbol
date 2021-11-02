require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Team Statistics Class Tests'
require './lib/team_stats'

RSpec.describe TeamStats do
  let(:team_stats1) { TeamStats.new }
  
  describe '#initialize' do
    it 'exists' do
      expect(team_stats1).to be_instance_of(TeamStats)
    end
  end
end