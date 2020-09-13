require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './fixture/games_dummy.csv'
    @team_path = './fixture/teams_dummy.csv'
    @game_teams_path = './fixture/game_teams_dummy.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_find_team_results_by_season
    game_path = './fixture/game_blank.csv'
    team_path = './fixture/team_blank.csv'
    game_teams_path = './fixture/game_teams_blank.csv'

    tracker = StatTracker.new(game_path, team_path, game_teams_path)
    game_1 = mock("Season Game 1")
    game_2 = mock("Season Game 2")
    game_3 = mock("Season Game 3")

    tracker.game_manager.games << game_1
    tracker.game_manager.games << game_2
    tracker.game_manager.games << game_3

    game_1.stubs(:season).returns('20122013')
    game_2.stubs(:season).returns('20122013')
    game_3.stubs(:season).returns('20132014')
    game_1.stubs(:game_id).returns('123')
    game_2.stubs(:game_id).returns('456')
    game_3.stubs(:game_id).returns('789')

    assert_equal ["123", "456"], tracker.find_game_ids_for_season('20122013')
  end

  def test_it_can_return_team_stats_hash
    game_path = './fixture/game_blank.csv'
    team_path = './fixture/team_blank.csv'
    game_teams_path = './fixture/game_teams_blank.csv'

    tracker = StatTracker.new(game_path, team_path, game_teams_path)

    team = mock('Team Object')
    tracker.team_manager.teams << team

    team.stubs(:team_id).returns('45')

    expected = {
      '45' => { total_games: 0, total_goals: 0, away_games: 0, home_games: 0,
                away_goals: 0, home_goals: 0 }
    }

    assert_equal expected, tracker.initialize_team_stats_hash
  end

  def test_it_can_count_teams
    game_path = './fixture/games_count_teams.csv'
    team_path = './fixture/team_blank.csv'
    game_teams_path = './fixture/game_teams_blank.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 8, stat_tracker.count_of_teams
  end

  def test_it_can_find_best_offense
    game_path = './fixture/game_league_stats_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './fixture/game_teams_blank.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "FC Dallas", stat_tracker.best_offense
  end

  def test_it_can_find_the_worst_offense
    game_path = './fixture/game_league_stats_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './fixture/game_teams_blank.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Houston Dash", stat_tracker.worst_offense
  end

  def test_it_can_find_the_highest_scoring_visitor
    game_path = './fixture/game_league_stats_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './fixture/game_teams_blank.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Washington Spirit FC", stat_tracker.highest_scoring_visitor
  end

  def test_it_can_find_the_highest_scoring_home_team
    game_path = './fixture/game_league_stats_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './fixture/game_teams_blank.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "FC Dallas", stat_tracker.highest_scoring_home_team
  end

  def test_it_can_find_the_lowest_scoring_visitor
    game_path = './fixture/game_league_stats_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './fixture/game_teams_blank.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Toronto FC", stat_tracker.lowest_scoring_visitor
  end

  def test_it_can_find_the_lowest_scoring_home_team
    game_path = './fixture/game_league_stats_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './fixture/game_teams_blank.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "New York City FC", stat_tracker.lowest_scoring_home_team
  end
end
