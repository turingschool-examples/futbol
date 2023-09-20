require './spec/spec_helper'

RSpec.describe StatTracker do
  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'
  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  
  StatTracker.from_csv(locations)
  let(:stat_tracker) { StatTracker.new }

  describe '#initialize' do
    it 'can initialize' do
      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  describe '::from_csv' do
    it 'returns an instance of StatTracker' do
      expect(stat_tracker).to be_a(StatTracker)
      expect(stat_tracker.team_data).to be_a(CSV::Table)
      expect(stat_tracker.game).to be_a(CSV::Table)
      expect(stat_tracker.game_teams).to be_a(CSV::Table)
      expect(stat_tracker.percentage_home_win(true))
    end
  end
end