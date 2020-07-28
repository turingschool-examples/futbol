require "./test/test_helper"

class SeasonStatisticsTest < MiniTest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @season_statistics = SeasonStatistics.new(locations)
  end

  #need the following tests
  #scoped_season_games
  #games_teams_by_seasons_per_coach
  #coach_name_and_results`
  def test_it_has_a_winningest_coach
    assert_equal "Claude Julien", @season_statistics.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @season_statistics.winningest_coach("20142015")
  end

  def test_it_has_a_worst_coach
    assert_equal "Peter Laviolette", @season_statistics.worst_coach("20132014")
    assert "Craig MacTavish" || "Ted Nolan", @season_statistics.worst_coach("20142015")
  end

  def test_it_can_return_accuracy_for_each_team
    assert_equal ["16", 0.3042362002567394], @season_statistics.team_accuracy("20132014").first
  end

  def test_games_per_season_per_team
    assert_equal 30, @season_statistics.games_per_season_per_team("20132014").keys.count
    assert_equal 89, @season_statistics.games_per_season_per_team("20132014")["4"].count
    assert_equal 2, @season_statistics.games_per_season_per_team("20132014")["4"].first.goals
    assert_equal 107, @season_statistics.games_per_season_per_team("20132014")["3"].count
    assert_equal 3, @season_statistics.games_per_season_per_team("20132014")["3"].first.goals
  end

  def test_it_can_find_least_accurate_team_by_season
    assert_equal "New York City FC", @season_statistics.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @season_statistics.least_accurate_team("20142015")
  end

  def test_it_can_find_most_accurate_team_by_season
    assert_equal "Real Salt Lake", @season_statistics.most_accurate_team("20132014")
    assert_equal "Toronto FC", @season_statistics.most_accurate_team("20142015")
  end

  def test_team_tackles
    assert_equal 30, @season_statistics.team_tackles("20132014").keys.count
    assert_equal 1836, @season_statistics.team_tackles("20132014")["16"]
    assert_equal 2441, @season_statistics.team_tackles("20132014")["6"]
  end

  def test_find_the_fewest_tackles
    assert_equal "Atlanta United", @season_statistics.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @season_statistics.fewest_tackles("20142015")
  end

  def test_find_the_most_tackles
    assert_equal "FC Cincinnati", @season_statistics.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @season_statistics.most_tackles("20142015")
  end
end
