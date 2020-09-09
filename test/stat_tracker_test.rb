require "./test/test_helper"
require "mocha/minitest"
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
      2014020006=>6, 2014021002=>4, 2014020598=>3, 2014020917=>5, 2014020774=>4,
      2014020142=>5, 2014020981=>5, 2014020970=>5, 2014020002=>3, 2014020391=>3,
      2014020423=>3, 2014020643=>6, 2014020371=>2, 2014020845=>5, 2014021083=>4}
    assert_equal expected, @stats.sum_game_goals("20142015")
  end

  def test_it_can_determine_highest_and_lowest_game_score ###
    assert_equal 1, @stats.lowest_total_score
    assert_equal 6, @stats.highest_total_score
  end

  def test_it_can_find_total_games ###
    assert_equal 53, @stats.total_games
  end

  def test_it_can_determine_season_win_percentage
    assert_equal 18.75, @stats.season_win_percentage(1, "20142015")
    assert_equal 31.25, @stats.season_win_percentage(4, "20142015")
    assert_equal 43.75, @stats.season_win_percentage(6, "20142015")
    assert_equal 37.5, @stats.season_win_percentage(26, "20142015")
  end

  def test_it_can_filter_games_by_season
    expected_games_1 = @stats.filter_by_season("20122013")
    expected_games_2 = @stats.filter_by_season("20152016")
    expected_games_3 = @stats.filter_by_season("20142015")
    result_1 = expected_games_1.none? do |game|
      game.season == "20132014" && game.season == "20142015" && game.season == "20162017"
    end
    assert result_1
    assert_equal 4, expected_games_1.count
    result_2 = expected_games_2.any? do |game|
      game.season == "20122013" && game.season == "20132014" && game.season == "20162017"
    end
    assert_equal false, result_2
    assert_equal 5, expected_games_2.count
    result_3 = expected_games_3.any? do |game|
      game.season == "20142015"
    end
    assert result_3
    assert_equal 16, expected_games_3.count
  end

  def test_it_can_count_total_home_wins
    assert_equal 1, @stats.team_wins_as_home(1, "20142015")
    assert_equal 1, @stats.team_wins_as_home(4, "20142015")
    assert_equal 3, @stats.team_wins_as_home(6, "20142015")
    assert_equal 2, @stats.team_wins_as_home(26, "20142015")
  end

  def test_it_can_count_total_away_wins
    assert_equal 2, @stats.team_wins_as_away(1, "20142015")
    assert_equal 4, @stats.team_wins_as_away(4, "20142015")
    assert_equal 4, @stats.team_wins_as_away(6, "20142015")
    assert_equal 4, @stats.team_wins_as_away(26, "20142015")
  end

  def test_it_can_count_total_number_of_wins_per_season ###
    assert_equal 3, @stats.total_team_wins(1, "20142015")
    assert_equal 5, @stats.total_team_wins(4, "20142015")
    assert_equal 7, @stats.total_team_wins(6, "20142015")
    assert_equal 6, @stats.total_team_wins(26, "20142015")
  end

  def test_it_can_create_array_of_all_team_ids
    expected = [1, 4, 6, 14, 26]
    assert_equal expected, @stats.team_ids
  end

  def test_it_can_organize_season_win_percentage_for_each_team ###
    expected = {
      1 => 18.75,
      4 => 31.25,
      6 => 43.75,
      14 => 12.5,
      26 => 37.5
    }
    assert_equal expected, @stats.all_teams_win_percentage("20142015")
  end

  def test_it_can_determine_winningest_team
    assert_equal 6, @stats.winningest_team("20142015")
  end

  def test_it_can_determine_team_with_worst_winning_percentage
    assert_equal 14, @stats.worst_team("20142015")
  end

  def test_it_can_create_array_of_all_team_ids
    expected = [1, 4, 6, 14, 26]
    assert_equal expected, @stats.team_ids
  end

  def test_it_can_organize_season_win_percentage_for_each_team ###
    expected = {
      1 => 18.75,
      4 => 31.25,
      6 => 43.75,
      14 => 12.5,
      26 => 37.5
    }
    assert_equal expected, @stats.all_teams_win_percentage("20142015")
  end

  def test_it_can_determine_winningest_team
    assert_equal 6, @stats.winningest_team("20142015")
  end

  def test_it_can_determine_team_with_worst_winning_percentage
    assert_equal 14, @stats.worst_team("20142015")
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

  def test_it_can_determine_highest_and_lowest_game_score
    assert_equal 2, @stats.lowest_total_score("20142015")
    assert_equal 6, @stats.highest_total_score("20142015")
  end


# ~~~ LEAGUE METHOD TESTS~~~


# ~~~ SEASON METHOD TESTS~~~

def test_it_can_list_winningest_coach_by_season
  assert_equal "Claude Julien", @stats.winningest_coach("20142015")
end

def test_it_can_determine_the_worst_coach_by_season
  assert_equal "Jon Cooper", @stats.worst_coach("20142015")
end

# ~~~ TEAM METHOD TESTS~~~
end
