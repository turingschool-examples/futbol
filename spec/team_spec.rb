require 'spec_helper'

RSpec.describe Team do
  describe '#initialize' do
    it 'exists' do
      details = {team_id: "1", teamname: "Atlanta United"}
      team = Team.new(details)
      expect(team).to be_a(Team)
    end
  end
end
