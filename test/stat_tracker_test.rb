require 'SimpleCov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker.rb'
require './lib/game_collection'
require './lib/game_teams_collection'
require './lib/game_teams'
require './lib/game'
require './lib/team_collection'
require './lib/team'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
        games: './fixture_files/games_fixture.csv',
        # games: './data/little_games.csv',
        # games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './fixture_files/game_teams_fixture.csv'
        # game_teams: './data/little_game_teams.csv'
        # game_teams: './data/game_teams.csv'
      }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_load_collections_of_various_data
    assert_instance_of GameTeamsCollection, @stat_tracker.gtc
    assert_equal GameTeams, @stat_tracker.gtc.game_teams.first.class
    assert_instance_of GameCollection, @stat_tracker.game_collection
    assert_equal Game, @stat_tracker.game_collection.games.first.class
    assert_instance_of TeamCollection, @stat_tracker.team_collection
    assert_equal Team, @stat_tracker.team_collection.teams.first.class
  end

  def test_it_can_return_the_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_knows_the_lowest_scoring_home_team
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_return_the_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_can_return_percentage_of_home_wins
    assert_equal 0.56, @stat_tracker.percentage_home_wins
  end

  def test_can_return_percentage_of_visitor_wins
    assert_equal 0.11, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_return_percentage_ties
    assert_equal 0.33, @stat_tracker.percentage_ties
  end

  def test_it_can_return_a_count_of_games_per_season
    expected = {
      "20122013" => 5,
      "20152016" => 4
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_return_average_goals_per_game
    assert_equal 3.78, @stat_tracker.average_goals_per_game
  end

  def test_it_can_return_average_goals_by_season
    expected = {"20122013"=>3.6, "20152016"=>4.0}
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_show_the_worst_fans
    assert_equal [], @stat_tracker.worst_fans
  end

  def test_it_knows_the_hightest_scoring_home_team
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_home_team
  end

  def test_best_defense
    assert_equal "FC Dallas", @stat_tracker.best_defense
  end

  def test_it_can_return_lowest_score
    assert_equal 3, @stat_tracker.lowest_total_score
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Toronto FC", @stat_tracker.worst_offense
  end

  def test_worst_defense
    assert_equal "Houston Dynamo", @stat_tracker.worst_defense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_winningest_team
    assert_equal "FC Dallas", @stat_tracker.winningest_team
  end

  def test_it_can_return_team_names_by_id_number
    assert_equal "Atlanta United", @stat_tracker.team_name_by_id(1)
    assert_equal "LA Galaxy", @stat_tracker.team_name_by_id(17)
  end

  def test_team_with_the_most_tackles_in_a_season
    assert_equal "FC Dallas", @stat_tracker.most_tackles("20122013")
    assert_equal "Houston Dynamo",@stat_tracker.most_tackles("20152016")
  end

  def test_team_with_the_fewest_tackles_in_a_season
    assert_equal "Philadelphia Union", @stat_tracker.fewest_tackles("20122013")
    assert_equal "FC Cincinnati", @stat_tracker.fewest_tackles("20152016")
  end

  def test_it_knows_team_info
    expected = {
      "team_id" => "3",
      "franchise_id" => "10",
      "team_name" => "Houston Dynamo",
      "abbreviation" => "HOU",
      "link" => "/api/v1/teams/3"
      }
    assert_equal expected, @stat_tracker.team_info("3")
  end

  def test_it_knows_the_most_points_a_team_has_scored
    assert_equal 2, @stat_tracker.most_goals_scored("3")
  end

  def test_it_knows_the_fewest_points_a_team_has_scored
    assert_equal 2, @stat_tracker.fewest_goals_scored("3")
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_best_fans
    assert_equal "Philadelphia Union", @stat_tracker.best_fans
  end

  def test_lowest_scoring_visitor
    assert_equal "Toronto FC", @stat_tracker.lowest_scoring_visitor
  end
end
