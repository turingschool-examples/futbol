require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_fixture.csv'

    @file_locations = {
                        games: game_path,
                        teams: team_path,
                        game_teams: game_teams_path
                      }
    @stat_tracker = StatTracker.from_csv(@file_locations)
    @stat_tracker.test_with_mocks(mock())
  end

  def test_it_exists_and_has_attributes
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_highest_total_score
    @stat_tracker.game_manager.expects(:highest_total_score).returns(11)
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    @stat_tracker.game_manager.expects(:lowest_total_score).returns(0)
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins
    @stat_tracker.game_manager.expects(:percentage_home_wins).returns(0.44)
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    @stat_tracker.game_manager.expects(:percentage_visitor_wins).returns(0.36)
    assert_equal 0.36, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    @stat_tracker.game_manager.expects(:percentage_ties).returns(0.20)
    assert_equal 0.20, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected =  {
                  "20122013"=>806,
                  "20162017"=>1317,
                  "20142015"=>1319,
                  "20152016"=>1321,
                  "20132014"=>1323,
                  "20172018"=>1355
                }
    @stat_tracker.game_manager.expects(:count_of_games_by_season).returns(expected)
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    @stat_tracker.game_manager.expects(:average_goals_per_game).returns(4.22)
    assert_equal 4.22, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected =  {
                  "20122013"=>4.12,
                  "20162017"=>4.23,
                  "20142015"=>4.14,
                  "20152016"=>4.16,
                  "20132014"=>4.19,
                  "20172018"=>4.44
                }
    @stat_tracker.game_manager.expects(:average_goals_by_season).returns(expected)
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_count_of_teams
    @stat_tracker.team_manager.expects(:count_of_teams).returns(32)
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_best_offense
    @stat_tracker.game_teams_manager.expects(:best_offense)
    @stat_tracker.team_manager.expects(:team_name).returns("Reign FC")
    assert_equal "Reign FC", @stat_tracker.best_offense
  end

  def test_worst_offense
    @stat_tracker.game_teams_manager.expects(:worst_offense)
    @stat_tracker.team_manager.expects(:team_name).returns("Utah Royals FC")
    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    @stat_tracker.game_teams_manager.expects(:highest_scoring_visitor)
    @stat_tracker.team_manager.expects(:team_name).returns("FC Dallas")
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    @stat_tracker.game_teams_manager.expects(:highest_scoring_home_team)
    @stat_tracker.team_manager.expects(:team_name).returns("Reign FC")
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    @stat_tracker.game_teams_manager.expects(:lowest_scoring_visitor)
    @stat_tracker.team_manager.expects(:team_name).returns("San Jose Earthquakes")
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    @stat_tracker.game_teams_manager.expects(:lowest_scoring_home_team)
    @stat_tracker.team_manager.expects(:team_name).returns("Utah Royals FC")
    assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
  end

  def test_winningest_coach
    @stat_tracker.game_manager.expects(:game_ids_by_season).twice
    @stat_tracker.game_teams_manager.expects(:winningest_coach).returns("Claude Julien")
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
    @stat_tracker.game_teams_manager.expects(:winningest_coach).returns("Alain Vigneault")
    assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
  end

  def test_worst_coach
    @stat_tracker.game_manager.expects(:game_ids_by_season).twice
    @stat_tracker.game_teams_manager.expects(:worst_coach).returns("Peter Laviolette")
    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
    @stat_tracker.game_teams_manager.expects(:worst_coach).returns("Ted Nolan")
    assert_equal "Ted Nolan", @stat_tracker.worst_coach("20142015")
  end

  def test_most_accurate_team
    @stat_tracker.game_manager.expects(:game_ids_by_season).twice
    @stat_tracker.game_teams_manager.expects(:most_accurate_team).twice
    @stat_tracker.team_manager.expects(:team_name).returns("Real Salt Lake")
    assert_equal "Real Salt Lake", @stat_tracker.most_accurate_team("20132014")
    @stat_tracker.team_manager.expects(:team_name).returns("Toronto FC")
    assert_equal "Toronto FC", @stat_tracker.most_accurate_team("20142015")
  end

  def test_least_accurate_team
    @stat_tracker.game_manager.expects(:game_ids_by_season).twice
    @stat_tracker.game_teams_manager.expects(:least_accurate_team).twice
    @stat_tracker.team_manager.expects(:team_name).returns("New York City FC")
    assert_equal "New York City FC", @stat_tracker.least_accurate_team("20132014")
    @stat_tracker.team_manager.expects(:team_name).returns("Columbus Crew SC")
    assert_equal "Columbus Crew SC", @stat_tracker.least_accurate_team("20142015")
  end

  def test_most_tackles
    @stat_tracker.game_manager.expects(:game_ids_by_season).twice
    @stat_tracker.game_teams_manager.expects(:most_tackles).twice
    @stat_tracker.team_manager.expects(:team_name).returns("FC Cincinnati")
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20132014")
    @stat_tracker.team_manager.expects(:team_name).returns("Seattle Sounders FC")
    assert_equal "Seattle Sounders FC", @stat_tracker.most_tackles("20142015")
  end

  def test_fewest_tackles
    @stat_tracker.game_manager.expects(:game_ids_by_season).twice
    @stat_tracker.game_teams_manager.expects(:fewest_tackles).twice
    @stat_tracker.team_manager.expects(:team_name).returns("Atlanta United")
    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
    @stat_tracker.team_manager.expects(:team_name).returns("Orlando City SC")
    assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20142015")
  end

  def test_team_info
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }
    @stat_tracker.team_manager.expects(:team_info).returns(expected)
    assert_equal expected, @stat_tracker.team_info("18")
  end

  def test_best_season
    @stat_tracker.game_manager.expects(:best_season).returns("20132014")
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_worst_season
    @stat_tracker.game_manager.expects(:worst_season).returns("20142015")
    assert_equal "20142015", @stat_tracker.worst_season("6")
  end

  def test_average_win_percentage
    @stat_tracker.game_manager.expects(:average_win_percentage).returns(0.49)
    assert_equal 0.49, @stat_tracker.average_win_percentage("6")
  end

  def test_most_goals_scored
    @stat_tracker.game_manager.expects(:most_goals_scored).returns(7)
    assert_equal 7, @stat_tracker.most_goals_scored("18")
  end

  def test_fewest_goals_scored
    @stat_tracker.game_manager.expects(:fewest_goals_scored).returns(0)
    assert_equal 0, @stat_tracker.fewest_goals_scored("18")
  end

  def test_favorite_opponent
    @stat_tracker.game_manager.expects(:favorite_opponent)
    @stat_tracker.team_manager.expects(:team_name).returns("DC United")
    assert_equal "DC United", @stat_tracker.favorite_opponent("18")
  end

  def test_rival
    @stat_tracker.game_manager.expects(:rival)
    @stat_tracker.team_manager.expects(:team_name).returns("Houston Dash")
    assert_equal "Houston Dash", @stat_tracker.rival("18")
  end

  def test_with_mocks
    assert_instance_of Mocha::Mock, @stat_tracker.game_manager
    assert_instance_of Mocha::Mock, @stat_tracker.game_teams_manager
    assert_instance_of Mocha::Mock, @stat_tracker.team_manager
  end
end
