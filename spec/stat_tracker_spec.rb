require_relative 'spec_helper'

RSpec.describe StatTracker do
  let(:data) do
    {
      games: 'path/to/games.csv',
      teams: 'path/to/teams.csv',
      game_teams: 'path/to/game_teams.csv'
    }
  end
  let(:stat_tracker) { StatTracker.new(data) }

  #before :each mocks and stubs seem good here

  describe '#initialize' do
    it 'should initialize with the correct instance variables' do
      expect(stat_tracker.data).to eq(data)
      expect(stat_tracker.team_file).to be_a CSV
      expect(stat_tracker.game_file).to be_a CSV
      expect(stat_tracker.game_team_file).to be_a CSV 
      expect(stat_tracker.seasons).to be empty
    end
  end

  describe '.from_csv' do
    it 'should create a new instance of StatTracker' do
      expect(StatTracker.from_csv(data)).to be_a StatTracker 
    end
  end

  describe '#create_teams' do
    it 'should populate the @teams array with Team objects' do
      stat_tracker.create_teams
      expect(stat_tracker.teams).to all(be_a(Teams))
    end
  end
  
  describe '#create_teams' do
    it 'should populate the @teams array with Team objects' do
      stat_tracker.create_teams
      expect(Teams.count_of_teams).to eq 32
    end
  end
end
