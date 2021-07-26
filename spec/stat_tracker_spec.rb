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

      # stat_tracker = StatTracker.new
      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker[:games][0].data[:game_id]).to eq(2012030221)
    end
  end
end
