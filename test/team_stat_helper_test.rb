require_relative 'test_helper'

class TeamStatHelperTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    @stat_tracker ||= StatTracker.new({games: game_path, teams: team_path, game_teams: game_teams_path})
    @team_stat_helper ||= TeamStatHelper.new(@stat_tracker.game_table, @stat_tracker.team_table, @stat_tracker.game_team_table)
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
  end

end
