require_relative 'test_helper'

class GameTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @game_stats   = GameStats.new('./data/games.csv', @stat_tracker)
    @game         = Game.new(locations, @game_stats)
  end
end
