require_relative 'spec_helper'

RSpec.describe StatTracker do
  let(:game_path) {'./data/games.csv'}
  let(:team_path) {'./data/teams.csv'}
  let(:game_teams_path) {'./data/game_teams.csv'}

  let(:locations) {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }

	let(:stat_tracker) { StatTracker.from_csv(locations) }
  
  describe '#initialize' do
	  it 'exists' do
      expect(stat_tracker).to be_a StatTracker
	  end

    it 'has attributes' do
      expect(@stat1.game_ids).to eq([2012030221, 2012030222, 2012030223])
    end
end