require './test/test_helper'

class GameTeamCollectionTest < Minitest::Test
  def setup
    game_path       = './data/games_dummy.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path,
                }

    @stat_tracker         = StatTracker.from_csv(locations)
    @game_team_collection = GameTeamCollection.new(game_teams_path, @stat_tracker)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameTeamCollection, @game_team_collection
  end
end
