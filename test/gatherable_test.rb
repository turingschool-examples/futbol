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
    assert_instance_of Hash, @stat_tracker.games_by_team
  end

  def test_gatherable_can_return_home_games_by_team
    assert_instance_of Hash, @stat_tracker.home_games_by_team
  end

  def test_gatherable_can_return_away_games_by_team
    assert_instance_of Hash, @stat_tracker.away_games_by_team
  end

  def test_gatherable_can_return_wins_by_team
    # assert_instance_of Hash, @stat_tracker.wins_by_team(collection)
  end

  def test_gatherable_can_return_postseason_games_by_team
    assert_instance_of Hash, @stat_tracker.postseason_games_by_team
  end

  def test_gatherable_can_return_regular_season_games_by_team
    assert_instance_of Hash, @stat_tracker.regular_season_games_by_team
  end

  def test_gatherable_can_return_games_by_season
    assert_instance_of Hash, @stat_tracker.games_by_season('20132014')
  end

  def test_gatherable_can_return_season_games_by_coach
    assert_instance_of Hash, @stat_tracker.season_games_by_coach('20132014')
  end

  def test_gatherable_can_return_season_wins_by_coach
    assert_instance_of Hash, @stat_tracker.season_wins_by_coach('20132014')
  end

  def test_gatherable_can_return_home_wins_by_team
    assert_instance_of Hash, @stat_tracker.home_wins_by_team
  end

  def test_gatherable_can_return_away_wins_by_team
    assert_instance_of Hash, @stat_tracker.away_wins_by_team
  end

  def test_gatherable_can_return_goals_by_team
    assert_instance_of Hash, @stat_tracker.goals_by_team
  end

  def test_gatherable_can_return_home_goals_by_team
    assert_instance_of Hash, @stat_tracker.home_goals_by_team
  end

  def test_gatherable_can_return_away_goals_by_team
    assert_instance_of Hash, @stat_tracker.away_goals_by_team
  end

  def test_gatherable_can_return_goals_against_team
    assert_instance_of Hash, @stat_tracker.goals_against_team
  end

  def test_gatherable_can_return_get_team_name_by_id
    assert_instance_of String, @stat_tracker.get_team_name_by_id('3')
  end

  def test_gatherable_can_return_team_hash
    # assert_instance_of Hash, @stat_tracker.team_hash(row, team_id)
  end

  def test_gatherable_can_return_team_season_hash
    # assert_instance_of Hash, @stat_tracker.team_season_hash(row, collection_type, season_hash, team_id)
  end

  def test_gatherable_can_return_season_data_array
    # assert_instance_of Hash, @stat_tracker.season_data_array(season_hash, team_id)
  end

  def test_gatherable_can_return_team_key
    # assert_instance_of Hash, @stat_tracker.team_key(season_hash)
  end

  def test_gatherable_can_return_season_key
    # assert_instance_of Hash, @stat_tracker.season_key(season_hash, key)
  end

  def test_gatherable_can_return_season_parse
    # assert_instance_of Hash, @stat_tracker.season_parse(key, season_key, season_data, hash)
  end
end
