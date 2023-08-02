require_relative 'spec_helper'

RSpec.describe StatTracker do
  let(:stats) { StatTracker.from_csv }
  
  describe 'exists' do
    it 'initializes' do
      expect(stats).to be_a StatTracker
    end

    xit 'has readable attributes' do
      expect(stats.data)
      expect(stats.team_file)
      expect(stats.game_file)
      expect(stats.game_team_file)
    end
  end

  describe '#create_teams' do
    it 'creates an array of teams' do
      expect(stats.teams).to be empty
      stats.create_teams
      expect(stats.teams).to be_an Array
    end
  end

  describe '#count_of_teams' do
    it 'counts the total number of teams' do
      expect(stats.count_of_teams).to be 32
    end
  end
end
