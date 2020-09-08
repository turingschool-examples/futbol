require "./test/test_helper"
require "./lib/stat_tracker"

class StatTrackerTest < Minitest::Test
  def setup
    @stats = StatTracker.from_csv
  end

  def test_it_is_a_stat_tracker
    assert_instance_of StatTracker, @stats
  end

  def test_it_has_access_to_other_classes
    assert_instance_of Game, @stats.games[0]
    assert_equal 53, @stats.games.count
    assert_instance_of Team, @stats.teams[0]
    assert_equal 5, @stats.teams.count
    assert_instance_of GameTeam, @stats.game_teams[0]
    assert_equal 106, @stats.game_teams.count
  end

  # ~~~ HELPER METHOD TESTS~~~

  def test_it_can_sum_goals_per_game ###
    expected = {
      2014020006=>6, 2014021002=>4, 2014020598=>3, 2014020917=>5, 2014020774=>4, 2017020012=>2, 2014020142=>5, 2015020007=>5, 2013021198=>4, 2013020371=>4, 2013020203=>1, 2014020981=>5, 2013020649=>5, 2012020030=>3, 2012020389=>5, 2013021160=>5, 2014020970=>5, 2012020355=>3, 2014020002=>3, 2014020391=>3, 2014020423=>3, 2016020952=>5, 2016020019=>5, 2017020898=>5, 2014020643=>6, 2013020334=>3, 2013021221=>5, 2015020608=>3, 2015020727=>5, 2015020643=>5, 2016020747=>5, 2017030211=>6, 2013020667=>4, 2014020371=>2, 2016020116=>4, 2017030114=>4, 2016020592=>4, 2012020133=>3, 2017030213=>3, 2017030214=>5, 2014020845=>5, 2013020321=>5, 2013020285=>2, 2014021083=>4, 2017020156=>3, 2013020739=>5, 2013020088=>4, 2016020797=>3, 2017020467=>4, 2015020836=>1, 2016020715=>4
    }
    assert_equal expected, @stats.sum_game_goals
  end

  def test_it_can_determine_highest_and_lowest_game_score ###
    assert_equal 1, @stats.lowest_total_score
    assert_equal 6, @stats.highest_total_score
  end

  def test_it_can_find_total_games ###
    assert_equal 53, @stats.total_games
  end

  def test_it_can_find_percentage
    wins = ["game1", "game2", "game3"]
    assert_equal 50.00, @stats.find_percent(wins, 6)
  end

  def test_it_can_get_team_name_from_team_id
    assert_equal "Chicago Fire", @stats.team_names_by_team_id(4)
  end

  def test_it_can_get_total_scores_by_team
    expected = {"1"=>43, "4"=>37, "14"=>47, "6"=>47, "26"=>37}
    assert_equal expected, @stats.total_scores_by_team
  end

  def test_it_can_get_number_of_games_by_team
    expected = {"1"=>23, "4"=>22, "14"=>21, "6"=>20, "26"=>20}
    assert_equal expected, @stats.games_containing_team
  end

  def test_it_can_get_average_scores_per_team
    expected = {"1"=>1.87, "4"=>1.68, "14"=>2.24, "6"=>2.35, "26"=>1.85}
    assert_equal expected, @stats.average_scores_by_team
  end

# ~~~ GAME METHOD TESTS~~~
  def test_it_can_get_percentage_away_games_won ###
    assert_equal 30.19, @stats.percentage_away_wins
  end

  def test_it_can_get_percentage_ties ###
    assert_equal 15.09, @stats.percentage_ties
  end

  def test_it_can_get_percentage_home_wins ###
    assert_equal 54.72, @stats.percentage_home_wins
  end

  def test_it_can_see_count_of_games_by_season ###
    expected = {"20142015"=>16, "20172018"=>9, "20152016"=>5, "20132014"=>12, "20122013"=>4, "20162017"=>7}

    assert_equal expected, @stats.count_of_games_by_season
  end

# ~~~ LEAGUE METHOD TESTS~~~
  def test_worst_offense
    assert_equal "Chicago Fire", @stats.worst_offense
  end

  def test_best_offense
    assert_equal "FC Dallas", @stats.best_offense
  end


# ~~~ SEASON METHOD TESTS~~~


# ~~~ TEAM METHOD TESTS~~~
end
