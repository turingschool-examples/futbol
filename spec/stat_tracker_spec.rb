require './lib/stat_tracker'

RSpec.describe StatTracker do
  context '#initialize' do
    it 'exists' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.new

      expect(stat_tracker).to be_a StatTracker
    end

    it 'accepts data' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

      stat_tracker = StatTracker.new    
    end
  end
end

