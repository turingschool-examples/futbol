require_relative "test_helper"

class SeasonStatHelperTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_team_path = './data/game_teams.csv'
    @stat_tracker ||= StatTracker.from_csv({games: game_path, teams: team_path, game_teams: game_team_path})
    @season_stat_helper ||= SeasonStatHelper.new(@stat_tracker.game_table, @stat_tracker.team_table, @stat_tracker.game_team_table)
  end

  def test_should_exist
    assert_instance_of SeasonStatHelper, @season_stat_helper
  end

  def test_find_all_seasons
    expected = ["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"]
    assert_equal expected, @season_stat_helper.find_all_seasons
  end

  def test_coaches_per_season
    seasons = ["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"]
    assert @season_stat_helper.coaches_per_season(seasons)["20122013"].keys.include?("Claude Julien")
    assert @season_stat_helper.coaches_per_season(seasons)["20122013"].keys.include?("John Tortorella")
  end

  def test_collects_season_with_games
    season_with_games = @season_stat_helper.collects_season_with_games
    assert_equal ["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"], @season_stat_helper.collects_season_with_games.keys
    assert_equal 806, season_with_games["20122013"].length
  end

  def test_collect_shots_per_season
    shots_per_season = @season_stat_helper.collect_shots_per_season("20122013")
    assert_equal 358, shots_per_season["Philadelphia Union"]
    assert_equal 337, shots_per_season["Vancouver Whitecaps FC"]
  end

  def test_collect_goals_per_team
    goals_per_team = @season_stat_helper.collect_goals_per_team("20142015")
    assert_equal 204, goals_per_team["Seattle Sounders FC"]
    assert_equal 165, goals_per_team["Vancouver Whitecaps FC"]
  end

  def test_team_tackles_by_season
    games = @season_stat_helper.collects_season_with_games["20122013"]
    tackles = @season_stat_helper.team_tackles_by_season(games)

    assert_equal 1335, tackles[15]
    assert_equal 935, tackles[20]
  end

end
