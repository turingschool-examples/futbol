require './spec/spec_helper'

require './spec/spec_helper'

RSpec.describe StatTracker do
  let(:stat_tracker) { StatTracker.new(locations) }
  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'
  let(:locations) { {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  }

  describe '#initialize' do
    it 'can initialize' do
      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  describe '::from_csv' do
    it 'returns an instance of StatTracker' do
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker).to be_a(StatTracker)
      expect(stat_tracker.team_data).to be_a(Array)
      stat_tracker.team_data.each do |team|
        expect(team).to be_a(String)
      end
    end
  end
end