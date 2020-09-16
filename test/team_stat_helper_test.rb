require_relative 'test_helper'

class TeamStatHelperTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    @stat_tracker ||= StatTracker.new({games: game_path, teams: team_path, game_teams: game_teams_path})
    @team_stat_helper ||= TeamStatHelper.new(@stat_tracker.game_table, @stat_tracker.team_table, @stat_tracker.game_team_table)
    @team_id_with_float = {3 =>0.3684210526315789,
                  4 =>0.43333333333333335,
                  5 =>0.5116279069767442,
                 10 =>0.16666666666666666,
                  2 =>0.3870967741935484,
                  14=>0.15384615384615385,
                  29=>0.35714285714285715,
                  54=>0.42857142857142855,
                  24=>0.4,
                  7=>0.16666666666666666,
                  1=>0.2916666666666667,
                  26=>0.3,
                  13=>0.3684210526315789,
                  52=>0.2,
                  8=>0.2777777777777778,
                  25=>0.7,
                  21=>0.3,
                  30=>0.2,
                  28=>0.3,
                  18=>0.3,
                  9=>0.3888888888888889,
                  6=>0.2222222222222222,
                  23=>0.3,
                  17=>0.2,
                  22=>0.2,
                  12=>0.34615384615384615,
                  53=>0.5,
                  20=>0.4,
                  19=>0.4,
                  16=>0.3,
                  27=>0.0}
  end

  def test_collect_seasons
    expected = ["20122013", "20172018", "20132014", "20142015", "20152016", "20162017"]
    assert_equal expected, @team_stat_helper.collect_seasons("6").keys
    assert_equal 53, @team_stat_helper.collect_seasons("8")["20122013"].length
    assert_equal 82, @team_stat_helper.collect_seasons("6")["20142015"].length
  end

  def test_collect_wins_per_season
    expected = ["20152016", "20172018", "20132014", "20122013", "20142015", "20162017"]
    assert_equal expected, @team_stat_helper.collect_wins_per_season("28").keys
    assert_equal 19, @team_stat_helper.collect_wins_per_season("53")["20142015"]
    assert_equal 26, @team_stat_helper.collect_wins_per_season("22")["20152016"]
  end

  def test_collect_losses_per_season
    expected = ["20122013", "20152016", "20142015", "20132014", "20162017", "20172018"]
    assert_equal expected, @team_stat_helper.collect_losses_per_season("2").keys
    expected_1 = [30, 63, 62, 56, 55, 48]
    assert_equal expected_1, @team_stat_helper.collect_losses_per_season("22").values
    assert_equal 43, @team_stat_helper.collect_losses_per_season("8")["20162017"]
  end

  def test_games_for_team_id
    assert_equal 1014, @team_stat_helper.games_for_team_id("19").length
    assert_equal 926, @team_stat_helper.games_for_team_id("1").length
    assert_equal 656, @team_stat_helper.games_for_team_id("53").length
  end

  def test_add_game_wins_to_win_count
    game_table = @stat_tracker.game_table
    info = []
    count = 0
    game_table.values.each do |game|
      break if count == 5
      if game.away_team_id == 6
        info << game
        count += 1
      end
    end
    assert_equal 5, @team_stat_helper.add_game_wins_to_win_count("6", info)
  end

  def test_add_game_losses_to_loss_count
    game_table = @stat_tracker.game_table
    info = []
    count = 0
    game_table.values.each do |game|
      break if count == 5
      if game.away_team_id == 6
        info << game
        count += 1
      end
    end
    assert_equal 0, @team_stat_helper.add_game_losses_to_loss_count("6", info)
  end

  def test_games_for_team_id
    assert_equal 1020, @team_stat_helper.games_for_team_id("6").length
    assert_equal 656, @team_stat_helper.games_for_team_id("53").length
  end

  def test_win_percentages_by_team
    opponents = {
                5 => 7,
                9 => 2,
                7 => 9,
                2 => 5
              }
    game_count = {
                5 => 2,
                9 => 8,
                7 => 4,
                2 => 20
    }
    expected   = {
                5 => 3.5,
                9 => 0.25,
                7 => 2.25,
                2 => 0.25
    }
     assert_equal expected, @team_stat_helper.win_percentages_by_team(opponents, game_count)
  end

  def test_min_percentage_favorite_team_team_name
    actual = @team_stat_helper.min_percentage_favorite_team_team_name(@team_id_with_float)
    assert_equal "San Jose Earthquakes", actual
  end

  def test_max_percentage_favorite_team_team_name
    actual = @team_stat_helper.max_percentage_favorite_team_team_name(@team_id_with_float)
    assert_equal "Chicago Red Stars", actual
  end

end
