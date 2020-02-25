require 'minitest/autorun'
require 'minitest/pride'
require './lib/league_statistics'
require './lib/team'
require './lib/game'
require './lib/game_team'


class Test < Minitest::Test
  def setup
    game_path = './test/fixtures/games_truncated.csv'
    team_path = './test/fixtures/teams_truncated.csv'
    game_teams_path = './test/fixtures/game_teams_truncated.csv'

    # game_path = './data/games.csv'
    # team_path = './data/teams.csv'
    # game_teams_path = './data/game_teams.csv'
    Game.create_games(game_path)
    Team.create_teams(team_path)
    GameTeam.create_game_teams(game_teams_path)

    @league = LeagueStatistics.new
  end

  def test_it_can_count_teams
    skip
    assert_equal 32, @league.count_of_teams
  end

  def test_it_can_find_team_names
    skip
    assert_equal "FC Dallas", @league.find_team_names(6)
  end

  def test_it_can_calculate_goals_per_team
    skip
    expected = {
      3=>[2, 2, 1, 2, 1],
      6=>[3, 3, 2, 3, 3, 3, 4, 2, 1],
      5=>[0, 1, 1, 0],
      17=>[1, 2, 3, 2, 1, 3, 1],
      16=>[2, 1, 1, 0, 2, 2, 2],
      9=>[2, 1, 4],
      8=>[2, 3, 1, 2]
    }
    assert_equal expected, @league.goals_per_team
  end

  def test_it_can_average_goals_per_team
    skip
    expected = {
      3=>1.6,
      6=>2.67,
      5=>0.5,
      17=>1.86,
      16=>1.43,
      9=>2.33,
      8=>2.0
    }
    assert_equal expected, @league.average_goals_per_team
  end

  def test_it_can_tell_best_offense
    skip
    assert_equal "FC Dallas", @league.best_offense
  end

  def test_it_can_tell_worst_offense
    skip
    assert_equal "Sporting Kansas City", @league.worst_offense
  end

  def test_it_can_tell_games_teams_and_allowed_goals
    skip
    assert_equal [3, 3, 2, 3, 3], @league.games_teams_and_allowed_goals[3]
  end

  def test_it_can_average_games_teams_and_allowed_goals
    skip
    assert_equal 2.8, @league.average_games_teams_and_allowed_goals[3]
  end

  def test_it_can_tell_best_defense
    skip
    assert_equal "Orlando Pride", @league.best_defense
  end

  def test_it_can_tell_worst_defense
    skip
    assert_equal "New York Red Bulls", @league.worst_defense
  end

  def test_it_can_tell_visiting_teams_and_goals
    skip
    assert_equal [2, 3, 3, 4, 3], @league.visiting_teams_and_goals[6]
  end

  def test_it_can_tell_average_visiting_teams_and_goals
    skip
    assert_equal 3, @league.average_visiting_teams_and_goals[6]
  end

  def test_it_can_tell_highest_scoring_visitor
    skip
    assert_equal "Orlando Pride", @league.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    skip
    assert_equal "DC United", @league.lowest_scoring_visitor
  end

  def test_it_can_return_home_teams_and_goals
    skip
  end

  def test_highest_scoring_home_team
    skip
    assert_equal "", @league.highest_scoring_home_team
  end


  def test_it_can_tell_lowest_scoring_home_team
    skip
    assert_equal "", @league.lowest_scoring_home_team
  end

  def test_it_can_tell_winningest_team
    skip
    assert_equal "", @league.winningest_team
  end

  def test_it_can_tell_best_fans
    skip
    assert_equal "", @league.best_fans
  end

  def test_it_can_tell_worst_fans
    skip
    assert_equal [], @league.worst_fans
  end

  def test_tackles_per_team_in_season
    assert_equal 271, @league.tackles_per_team_in_season(6, 20122013)
  end

  def test_find_games_in_season
    skip
    assert_equal [], @league.find_games_in_season(20122013)
  end

  def test_find_game_teams_season
    skip
    assert_equal true, @league.find_game_teams_in_season(20122013)

  end

  def test_sum_of_tackles_by_team
    skip
    assert_equal "", @league.sum_of_tackles_by_team(20122013)
  end

  def test_most_tackles
    assert_equal "FC Dallas", @league.most_tackles(20122013)
    # assert another season here to test if it works on more then just 20122013
  end

  def test_fewest_tackles
    assert_equal "New York City FC", @league.fewest_tackles(20122013)
    # assert another season here to test if it works on more then just 20122013
  end
end
