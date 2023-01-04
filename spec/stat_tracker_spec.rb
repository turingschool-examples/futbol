require_relative 'spec_helper'

RSpec.describe StatTracker do

  let(:stat_tracker) { 
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    StatTracker.from_csv(locations) 
  }
    
  describe '#initialize' do
	  it 'exists' do
      expect(stat_tracker).to be_a StatTracker
	  end

    it 'has attributes' do
    
      expect(stat_tracker.game_teams).to be_a(Hash)
      expect(stat_tracker.games).to be_a(Hash)
      expect(stat_tracker.teams).to be_a(Hash)
    end
  end

  describe '#count_teams' do
    it 'can count # of teams' do
      
      expect(stat_tracker.teams).to eq(32)
    end
  end
end