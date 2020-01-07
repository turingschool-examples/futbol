require 'minitest/autorun'
require 'minitest/pride'
require './lib/season'

class SeasonTest < Minitest::Test

  def setup
    Season.from_csv('./data/game_teams_dummy.csv')
    @season = Season.all[0]
    Game.from_csv('./data/games_dummy.csv')
    @game = Game.all[0]
    Team.from_csv('./data/teams.csv')
    @team = Team.all[0]
  end

  def test_it_exists
    assert_instance_of Season, @season
  end

  def test_it_can_determine_total_home_games_played_by_team_id
    skip
    assert_equal ({6=>2, 12=>1, 10=>1, 21=>1, 53=>2, 1=>2, 24=>1, 4=>2}), Season.total_home_games_played
  end

  def test_it_can_determine_total_away_games_played_by_team_id
    skip
    assert_equal ({3=>2, 23=>2, 5=>1, 19=>1, 28=>1, 25=>1, 2=>1, 10=>1, 6=>1}), Season.total_away_games_played
  end

  def test_it_can_determine_total_home_win_percentage
    skip
    assert_equal ({6=>2, 12=>1, 10=>1, 21=>1, 53=>2, 1=>2, 24=>1, 4=>2}), Season.home_win_percentage
  end

  def test_it_can_determine_home_win_percentage
    skip
    assert_equal "sfgdfg", Season.home_win_percentage
  end

  def test_it_can_determine_best_fans
    skip
    assert_equal "sfgdfg", Season.best_fans
  end

  def test_it_can_determine_worst_fans
    skip
    assert_equal "sfgdfg", Season.worst_fans
  end

  def test_it_can_determine_winningest_team_across_all_seasons
    skip
    assert_equal "sfjghdfjhg", Game.winningest_team
  end

  def test_it_can_determine_home_win_percentage

  end

  def test_it_can_filter_team_stats_by_season
    skip
    assert_equal () , Season.seasons_filter("20122013")
  end

  def test_case_name_it_can_find_shot_to_goal_ratio_per_game

    assert_equal ({3=>[0.25, 0.22], 6=>[0.25, 0.38], 22=>[0.0], 17=>[0.43, 0.43],
      1=>[0.29, 0.33], 10=>[0.4, 0.43, 0.4], 13=>[0.29, 0.25], 2=>[0.43, 0.2],
      19=>[0.25], 28=>[0.5], 9=>[0.0, 0.08], 18=>[0.33], 7=>[1.0], 52=>[0.33],
      4=>[0.33]}), Season.shot_to_goal_ratio_per_game("20122013")
  end

  def test_it_can_find_average_shots_per_goal_by_team
    hash = ({3=>[0.25, 0.22], 6=>[0.25, 0.38], 22=>[0.0], 17=>[0.43, 0.43],
      1=>[0.29, 0.33], 10=>[0.4, 0.43, 0.4], 13=>[0.29, 0.25], 2=>[0.43, 0.2],
      19=>[0.25], 28=>[0.5], 9=>[0.0, 0.08], 18=>[0.33], 7=>[1.0], 52=>[0.33],
      4=>[0.33]})
    assert_equal ({3=>0.24, 6=>0.32, 22=>0.0, 17=>0.43, 1=>0.31, 10=>0.41,
      13=>0.27, 2=>0.32, 19=>0.25, 28=>0.5, 9=>0.04, 18=>0.33, 7=>1.0, 52=>0.33,
      4=>0.33}), Season.average_shots_per_goal_by_team(hash)
  end

  def test_it_can_find_the_max_value_and_team
    hash = {3=>0.24, 6=>0.32, 22=>0.0, 17=>0.43, 1=>0.31, 10=>0.41,
      13=>0.27, 2=>0.32, 19=>0.25, 28=>0.5, 9=>0.04, 18=>0.33, 7=>1.0, 52=>0.33,
      4=>0.33}
      assert_equal ("Utah Royals FC"), Season.max_value_team(hash)
  end

  def test_it_can_find_the_min_value_and_team
    hash = {3=>0.24, 6=>0.32, 22=>0.0, 17=>0.43, 1=>0.31, 10=>0.41,
      13=>0.27, 2=>0.32, 19=>0.25, 28=>0.5, 9=>0.04, 18=>0.33, 7=>1.0, 52=>0.33,
      4=>0.33}
      assert_equal ("Washington Spirit FC"), Season.min_value_team(hash)
  end

  def test_it_can_find_the_most_accurate_team
    assert_equal ("Utah Royals FC"), Season.most_accurate_team("20122013")
  end

  def test_it_can_find_the_least_accurate_team
    assert_equal ("Washington Spirit FC"), Season.least_accurate_team("20122013")
  end

end
