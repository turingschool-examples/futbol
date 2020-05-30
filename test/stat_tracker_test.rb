require './test/helper_test'
require './lib/stat_tracker'
require './lib/game_stats'
require './lib/game_collection'
require './lib/game_team_collection'
require './lib/team_collection'
require './lib/league_stats'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
      }

    @stat_tracker = StatTracker.from_csv(@locations)
    @games_collection = GameCollection.new("./data/games.csv")
    @game_stats = GameStats.new(@games_collection)
    @game_teams_collection = GameTeamCollection.new("./data/game_teams.csv")
    @league_stats = LeagueStats.new(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end
end
