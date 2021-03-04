require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @teams_path = './data/teams.csv'
    @games_path = './data/games.csv'
    @game_teams_path = './data/game_teams.csv'
    @locations = {
      teams: @teams_path,
      games: @games_path,
      game_teams: @game_teams_path
    }
    @tracker = StatTracker.from_csv(@locations)
  end

  def test_has_attributes

    refute_equal nil, @tracker.games
    refute_equal nil, @tracker.game_teams
    refute_equal nil, @tracker.teams
  end

  def test_highest_total_score
    assert_equal 11, @tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 0, @tracker.lowest_total_score
  end

  def test_percentage_of_home_wins
    assert_equal 0.44, @tracker.percentage_home_wins
  end

  def test_percentage_of_away_wins
    assert_equal 0.36, @tracker.percentage_away_wins
  end

  def test_percentage_of_ties
    assert_equal 0.20, @tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    assert_equal expected, @tracker.count_of_games_by_season
  end

  def test_number_of_teams
    assert_equal @tracker.count_of_teams, 32
  end

  def test_best_offense
    assert_equal "Reign FC", @tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Utah Royals FC", @tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Reign FC", @tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @tracker.lowest_scoring_home_team
  end

  def test_team_info
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    assert_equal expected, @tracker.team_info("18")
  end

  def test_best_season
    assert_equal "20132014", @tracker.best_season("6")
  end

  def test_worst_season
    assert_equal "20142015", @tracker.worst_season("6")
  end

  def test_average_win_percentage
    assert_equal 0.49, @tracker.average_win_percentage("6")
  end

  def test_most_goals_scored
    assert_equal 7, @tracker.most_goals_scored("18")
  end

  def test_fewest_goals_scored
    assert_equal 0, @tracker.fewest_goals_scored("18")
  end

  def test_favorite_opponent
    assert_equal 14, @tracker.favorite_opponent("18")
  end

  def test_rival
    assert_equal "LA Galaxy" || "Houston Dash", @tracker.rival("18")
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @tracker.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @tracker.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "Peter Laviolette", @tracker.worst_coach("20132014")
    assert_equal "Craig MacTavish" || "Ted Nolan", @tracker.worst_coach("20142015")
  end

  def test_most_accurate_team
    assert_equal "Real Salt Lake", @tracker.most_accurate_team("20132014")
    assert_equal "Toronto FC", @tracker.most_accurate_team("20142015")
  end

  def test_least_accurate_team
    assert_equal "New York City FC", @tracker.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @tracker.least_accurate_team("20142015")
  end

  def test_most_tackles
    assert_equal "FC Cincinnati", @tracker.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @tracker.most_tackles("20142015")
  end

  def test_fewest_tackles
    assert_equal "Atlanta United", @tracker.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @tracker.fewest_tackles("20142015")
  end

end
