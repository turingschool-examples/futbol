require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def test_it_exists
    games_path = './data/games.csv'
    teams_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: games_path,
      teams: teams_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.new(locations)

    assert_instance_of StatTracker, stat_tracker
  end

  def test_attributes
    games_path = './data/games.csv'
    teams_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: games_path,
      teams: teams_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.new(locations)

    assert_equal games_path, stat_tracker.games_path
    assert_equal teams_path, stat_tracker.teams_path
    assert_equal game_teams_path, stat_tracker.game_teams_path
  end

  def test_from_csv
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_instance_of StatTracker, stat_tracker
  end

  def test_best_offense
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 'Reign FC', stat_tracker.best_offense
  end

  def test_worst_offense
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 'Utah Royals FC', stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor_team
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 'FC Dallas', stat_tracker.highest_scoring_visitor_team
  end

  def test_lowest_scoring_visitor_team
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    assert_equal 'San Jose Earthquakes', stat_tracker.lowest_scoring_visitor_team
  end

  def test_lowest_scoring_home_team
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    assert_equal 'Utah Royals FC', stat_tracker.lowest_scoring_home_team
  end

  def test_highest_scoring_home_team
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

  assert_equal 'Reign FC', stat_tracker.highest_scoring_home_team
  end
end
