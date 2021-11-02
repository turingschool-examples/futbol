require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Team Class Tests'
require './lib/team'

RSpec.describe Team do
  let(:team1) { Team.new }
  
  describe '#initialize' do
    it 'exists' do
      expect(team1).to be_instance_of(Team)
    end
  end
end
