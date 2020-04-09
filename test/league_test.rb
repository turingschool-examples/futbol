require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/league'
require './lib/game'
require './lib/team'
require './lib/game_stats'

class LeagueTest < Minitest::Test
  def test_it_exists
    league = League.new
    assert_instance_of League, league
  end

  def test_count_of_teams
    league = League.new
    Team.from_csv("./data/teams.csv")
    assert_equal 32, league.count_of_teams
  end

  def test_best_offense
    league = League.new
    Team.from_csv("./data/teams.csv")
    GameStats.from_csv("./test/fixtures/game_teams_truncated.csv")
    assert_equal "Orlando City SC", league.best_offense
  end

  def test_find_team_name
    league = League.new
    Team.from_csv("./data/teams.csv")
    GameStats.from_csv("./test/fixtures/game_teams_truncated.csv")
    assert_equal "Orlando City SC", league.find_team_id(30)
  end

  def test_worst_offense
    league = League.new
    Team.from_csv("./data/teams.csv")
    GameStats.from_csv("./test/fixtures/game_teams_truncated.csv")
    assert_equal "Washington Spirit FC", league.worst_offense
  end

  def test_highest_scoring_visitor
    league = League.new
    GameStats.from_csv("./test/fixtures/game_teams_truncated.csv")
    Team.from_csv("./data/teams.csv")
    Game.from_csv("./test/fixtures/team_truncated.csv")
    assert_equal "Sporting Kansas City", league.highest_scoring_visitor
  end

end
