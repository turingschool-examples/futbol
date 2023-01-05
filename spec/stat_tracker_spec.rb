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
      expect(stat_tracker.game_teams).to be_a(CSV::Table)
      expect(stat_tracker.games).to be_a(CSV::Table)
      expect(stat_tracker.teams).to be_a(CSV::Table)
    end

    it 'can count # of teams' do 
      expect(stat_tracker.teams.count).to eq(32)
    end

    it 'can see game venues' do 
      expect(stat_tracker.games[:venue].include?("Toyota Stadium")).to eq(true)
    end

    it 'can see game team ids' do 
      expect(stat_tracker.game_teams[:game_id][1].to_i).to eq(2012030221)
    end
  end  

  describe 'compares total scores' do
    it 'finds total score' do
      expect(stat_tracker.total_score).to be_a(Array)
    end
    
    it 'finds highest total score' do
      expect(stat_tracker.highest_total_score).to eq(11)
    end

    it 'finds lowest total score' do
      expect(stat_tracker.lowest_total_score).to eq(0)
    end
  end
end