require_relative 'test_helper'
require './lib/modules/gatherable'
require './lib/modules/calculateable'
require './lib/tracker'
require './lib/stat_tracker'

class GatherableTest < Minitest::Test
  include Gatherable
  include Calculateable

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = Tracker.from_csv(locations)
  end

  def test_gatherable_exists
    gatherable = Gatherable

    assert_equal Gatherable, gatherable
  end

  def test_gatherable_can_return_games_by_team
    # assert_instance_of DATA, test_gatherable_can_return_games_by_team
  end

  def test_gatherable_can_return_home_games_by_team
    # assert_instance_of DATA, home_games_by_team
  end

  def test_gatherable_can_return_away_games_by_team
    # assert_instance_of DATA, away_games_by_team
  end

  def test_gatherable_can_return_wins_by_team
    # assert_instance_of DATA, wins_by_team(collection)
  end

  def test_gatherable_can_return_postseason_games_by_team
    # assert_instance_of DATA, postseason_games_by_team
  end

  def test_gatherable_can_return_regular_season_games_by_team
    # assert_instance_of DATA, regular_season_games_by_team
  end

  def test_gatherable_can_return_games_by_season
    # assert_instance_of DATA, games_by_season(season_id)
  end

  def test_gatherable_can_return_season_games_by_coach
    # assert_instance_of DATA, season_games_by_coach(season_id)
  end

  def test_gatherable_can_return_season_wins_by_coach
    # assert_instance_of DATA, season_wins_by_coach(season_id)
  end

  def test_gatherable_can_return_home_wins_by_team
    # assert_instance_of DATA, home_wins_by_team
  end

  def test_gatherable_can_return_away_wins_by_team
    # assert_instance_of DATA, away_wins_by_team
  end

  def test_gatherable_can_return_goals_by_team
    # assert_instance_of DATA, goals_by_team
  end

  def test_gatherable_can_return_home_goals_by_team
    # assert_instance_of DATA, home_goals_by_team
  end

  def test_gatherable_can_return_away_goals_by_team
    # assert_instance_of DATA, away_goals_by_team
  end

  def test_gatherable_can_return_goals_against_team
    # assert_instance_of DATA, goals_against_team
  end

  def test_gatherable_can_return_get_team_name_by_id
    # assert_instance_of DATA, team_name_by_id(team_id)
  end

  def test_gatherable_can_return_team_hash
    # assert_instance_of DATA, team_hash(row, team_id)
  end

  def test_gatherable_can_return_team_season_hash
    # assert_instance_of DATA, team_season_hash(row, collection_type, season_hash, team_id)
  end

  def test_gatherable_can_return_season_data_array
    # assert_instance_of DATA, season_data_array(season_hash, team_id)
  end

  def test_gatherable_can_return_team_key
    # assert_instance_of DATA, team_key(season_hash)
  end

  def test_gatherable_can_return_season_key
    # assert_instance_of DATA, season_key(season_hash, key)
  end

  def test_gatherable_can_return_season_parse
    # assert_instance_of DATA, season_parse(key, season_key, season_data, hash)
  end
end
