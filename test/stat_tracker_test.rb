require './test/test_helper'


class StatTrackerTest < MiniTest::Test

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
  end

  def test_it_exist
    skip
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_StatTracker_can_find_highest_total_score
    skip
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_highest_scoring_visitor
    # skip
    assert_equal "Sporting Kansas City", @stat_tracker.highest_scoring_visitor

  end

  def test_it_can_create_visiting_teams_hash
    assert_equal 7441, @stat_tracker.visiting_teams_by_game_id.count
    assert_equal Hash, @stat_tracker.visiting_teams_by_game_id.class

    assert_equal "16", @stat_tracker.visiting_teams_by_game_id["2012030236"]
  end

  def test_it_can_create_an_away_goals_and_team_id_hash
    # skip
    assert_equal 32, @stat_tracker.total_goals_by_away_team.count
    assert_equal Hash, @stat_tracker.total_goals_by_away_team.class

    assert_equal 458, @stat_tracker.total_goals_by_away_team["20"]

  end

  def test_it_can_create_hash_with_total_games_played_by_away_team
    assert_equal 32, @stat_tracker.away_teams_game_count_by_team_id.count
    assert_equal Hash, @stat_tracker.away_teams_game_count_by_team_id.class

    assert_equal 266, @stat_tracker.away_teams_game_count_by_team_id["3"]

    assert_nil @stat_tracker.away_teams_game_count_by_team_id["56"]
  end



end
