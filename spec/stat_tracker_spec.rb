require './spec/spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe StatTracker do
  describe '#initialize' do
    it 'exists with attributes' do
      game_path = './data/games_test.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      
      stat_tracker = StatTracker.new(locations)
      
      expect(stat_tracker).to be_a StatTracker
      expect(stat_tracker.games).to be_all Games
      expect(stat_tracker.teams).to be_all Teams
      expect(stat_tracker.game_teams).to be_all GameTeams
      expect(stat_tracker.games.first).to be_a Games
      expect(stat_tracker.teams.first).to be_a Teams
      expect(stat_tracker.game_teams.first).to be_a GameTeams
      expect(stat_tracker.games.first.game_id).to eq(2012030221)
      expect(stat_tracker.teams.first.team_id).to eq(1)
      expect(stat_tracker.game_teams.first.game_id).to eq(2012030221)
  end
end



end

