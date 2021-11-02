require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'League Statistics Class Tests'
require './lib/league_stats'

RSpec.describe LeagueStats do
  let(:league_stats1) { LeagueStats.new }
  
  describe '#initialize' do
    it 'exists' do
      expect(league_stats1).to be_instance_of(LeagueStats)
    end
  end
end