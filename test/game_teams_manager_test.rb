require "./test/test_helper"
require "./lib/game_teams_manager"

class GameTeamsManagerTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.from_csv
    @game_teams_manager = @stat_tracker.game_teams_manager
  end

  def test_it_exists
    assert_instance_of GameTeamsManager, @game_teams_manager
  end

  def test_it_can_create_a_table_of_games
    skip
    @game_teams_manager.game_teams.all? do |game|
      assert_instance_of GameTeam, game
    end
  end

  def test_it_can_organize_season_win_percentage_for_each_team
    expected = {
      "1" => 28.57,
      "4" => 42.86,
      "6" => 66.67,
      "14" => 0,
      "26" => 42.86
    }
    assert_equal expected, @game_teams_manager.all_teams_win_percentage("20142015")
  end

  def test_it_can_determine_winningest_team
    assert_equal "6", @game_teams_manager.winningest_team("20142015")
  end

  def test_it_can_determine_team_with_worst_winning_percentage
    assert_equal "14", @game_teams_manager.worst_team("20142015")
  end

  def test_it_can_list_winningest_coach_by_season
    assert_equal "Claude Julien", @game_teams_manager.winningest_coach("20142015")
  end

  def test_it_can_determine_the_worst_coach_by_season
    # assert_equal "Jon Cooper", @game_teams_manager.worst_coach("20122013")
    assert_equal "Jon Cooper", @game_teams_manager.worst_coach("20132014")
    assert_equal "Jon Cooper", @game_teams_manager.worst_coach("20142015")
    assert_equal "John Stevens", @game_teams_manager.worst_coach("20152016")
    assert_equal "Craig Berube", @game_teams_manager.worst_coach("20162017")
    assert_equal "Craig Berube", @game_teams_manager.worst_coach("20172018")
  end

  def test_it_can_get_game_teams_by_season
    @game_teams_manager.game_teams_by_season("20142015").each do |game|
      assert_instance_of GameTeam, game
    end
    assert_equal 8, @game_teams_manager.game_teams_by_season("20122013").count
    assert_equal 24, @game_teams_manager.game_teams_by_season("20132014").count
    assert_equal 32, @game_teams_manager.game_teams_by_season("20142015").count
    assert_equal 10, @game_teams_manager.game_teams_by_season("20152016").count
    assert_equal 14, @game_teams_manager.game_teams_by_season("20162017").count
    assert_equal 18, @game_teams_manager.game_teams_by_season("20172018").count
  end

  def test_it_can_show_total_tackles_per_team_per_season
    expected = {
      "1" => 30,
      "4" => 108,
      "6" => 31,
      "14" => 17
      # "26" => 0 (26 doesn't have any games this season)
    }
    assert_equal expected, @game_teams_manager.team_tackles("20122013")
  end

  def test_it_can_determine_team_with_most_season_tackles
    assert_equal "Chicago Fire", @game_teams_manager.most_tackles("20122013")
  end

  def test_it_can_determine_team_with_fewest_season_tackles
    assert_equal "DC United", @game_teams_manager.fewest_tackles("20122013")
  end

  def test_it_can_see_highest_scoring_visitor
    skip
    assert_equal "FC Dallas", @game_teams_manager.highest_scoring_visitor
  end

  def test_it_can_filter_gameteams_by_teamid
    assert @game_teams_manager.filter_by_teamid("6").all? {|gameteam| gameteam.team_id == "6"}
  end

  def test_it_can_create_gameteams_by_opponent
    assert_equal ["6", "26", "4", "1"], @game_teams_manager.game_teams_by_opponent("14").keys
    assert_equal 5, @game_teams_manager.game_teams_by_opponent("14")["6"].size
    assert_equal 4, @game_teams_manager.game_teams_by_opponent("14")["1"].size
    assert_equal 6, @game_teams_manager.game_teams_by_opponent("14")["4"].size
    assert_equal 6, @game_teams_manager.game_teams_by_opponent("14")["26"].size
  end

  def test_it_can_get_most_accurate_team_for_season
    assert_equal "FC Dallas", @game_teams_manager.most_accurate_team("20132014")
  end

  def test_it_can_get_least_accurate_team_for_season
    assert_equal "Atlanta United", @game_teams_manager.least_accurate_team("20132014")
  end

  def test_it_can_get_games_from_season_game_ids
    season_game_ids = @game_teams_manager.game_ids_per_season("20132014")
    assert_equal GameTeam, @game_teams_manager.find_game_teams(season_game_ids)[0].class
    assert_equal (season_game_ids.count * 2), @game_teams_manager.find_game_teams(season_game_ids).count
  end

  def test_it_can_get_shots_per_team
    expected = {"4"=>32, "14"=>26, "1"=>27, "6"=>24, "26"=>40}
    assert_equal expected, @game_teams_manager.shots_per_team_id("20132014")
  end

  def test_shots_per_goal_per_season_for_given_season
    expected = {"4"=>3.20, "14"=>2.89, "1"=>3.86, "6"=>2.40, "26"=>3.64}
    assert_equal expected, @game_teams_manager.shots_per_goal_per_season("20132014")
  end

end
