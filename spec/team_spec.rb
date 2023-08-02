require_relative 'spec_helper'

RSpec.describe Team do
  let(:team) { Team.new({team_id: 1, teamname: "Atlanta United"}) }

  describe '#exists' do
    it 'initializes' do
      expect(team).to be_a Team
    end
  end

  describe '#teamname' do
    it 'reads the team name' do
      expect(team.teamname).to eq("Atlanta United")
    end
    
  end
  
  describe '#team_id' do
    it 'reads the team id' do
      expect(team.team_id).to be 1
    end  
  end
end