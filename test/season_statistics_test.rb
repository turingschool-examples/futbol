require_relative 'test_helper'
require 'mocha/minitest'

class SeasonStatistcsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat ||= StatTracker.new(@locations)

  end

  def test_it_exists
    @stat.coaches_per_season(@stat.find_all_seasons)
  end

  def test_find_all_seasons
    assert_equal ["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"], @stat.find_all_seasons
  end

  def test_coaches_per_season
    assert @stat.coaches_per_season(@stat.find_all_seasons)["20132014"].include?("Claude Julien")
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @stat.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @stat.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "Peter Laviolette", @stat.worst_coach("20132014")
    assert_includes ["Craig MacTavish", "Ted Nolan"], @stat.worst_coach("20142015")
  end
end
