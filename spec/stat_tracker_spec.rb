require './lib/stat_tracker.rb'
require 'csv'
RSpec.describe StatTracker do
  describe '#initialize' do
    it 'exists' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      stat_tracker = StatTracker.new(game_path, team_path, game_teams_path)
      expect(stat_tracker).to be_an_instance_of(StatTracker)
    end
  end

  describe '#self::from_csv' do
    it '#returns an instance of stat_tracker' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      expect(StatTracker.from_csv(locations)).to be_an_instance_of(StatTracker)
    end
  end
end
