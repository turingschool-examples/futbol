require 'spec_helper'

RSpec.describe TeamsManager do
  context 'teams_manager' do
    teams_manager = TeamsManager.new('./data/teams.csv')

    it 'has attributes' do
      expect(teams_manager.teams).not_to be_empty
    end

    it 'makes teams' do
      expect(teams_manager).to respond_to(:make_objects)
    end

    it 'can find a team' do
      expect(teams_manager.team_info("18")).to be_a(Team)
    end

    it 'has a teams count in a league' do
      expect(teams_manager.count_of_teams).to eq(32)
    end

    it 'returns team name by team id' do
      expect(teams_manager.team_by_id('18')).to eq('Minnesota United FC')
    end
  end
end
