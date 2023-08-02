require_relative 'spec_helper'

RSpec.describe StatTracker do
  let(:data) do
    {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }
  end
  let(:stat_tracker) { StatTracker.new(data) }

  #before :each mocks and stubs seem good here

  describe '#initialize' do
    it 'should initialize with the correct instance variables' do
      expect(stat_tracker.data).to eq(data)
    end
  end

  describe '.from_csv' do
    it 'should create a new instance of StatTracker' do
      expect(StatTracker.from_csv(data)).to be_a StatTracker 
    end
  end

  # describe '#create_teams' do
  #   it 'should populate the @teams array with Team objects' do
  #     stat_tracker.create_teams
  #     expect(stat_tracker.teams).to all(be_a(Teams))
  #   end
  # end
  
  # describe '#create_teams' do
  #   it 'should populate the @teams array with Team objects' do
  #     stat_tracker.create_teams
  #     expect(stat_tracker.teams).to all(be_a(Teams))
  #   end
  # end
end
