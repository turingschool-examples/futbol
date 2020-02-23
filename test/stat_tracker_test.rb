require './lib/stat_tracker'
require './lib/game_collection'
require './lib/game_teams_collection'
require './lib/game_teams'
require './lib/game'
require './lib/team_collection'
require './lib/team'
require 'minitest/autorun'
require 'minitest/pride'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
        # games: './fixture_files/games_fixture.csv',
        games: './data/little_games.csv',
        teams: './data/teams.csv',
        # game_teams: './fixture_files/game_teams_fixture.csv'
        game_teams: './data/little_game_teams.csv'
      }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    skip
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_load_collections_of_various_data
    skip
    assert_instance_of GameTeamsCollection, @stat_tracker.gtc
    assert_equal GameTeams, @stat_tracker.gtc.game_teams.first.class
    assert_instance_of GameCollection, @stat_tracker.game_collection
    assert_equal Game, @stat_tracker.game_collection.games.first.class
    assert_instance_of TeamCollection, @stat_tracker.team_collection
    assert_equal Team, @stat_tracker.team_collection.teams.first.class
  end

  def test_it_can_return_the_highest_total_score
    skip
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_can_return_the_biggest_blowout
    skip
    assert_equal 5, @stat_tracker.biggest_blowout
  end

  def test_it_can_return_percentage_ties
    skip
    assert_equal 0.09, @stat_tracker.percentage_ties
  end

  def test_it_can_show_the_worst_fans
    skip
    assert_equal ["Real Salt Lake", "New England Revolution", "Portland Thorns FC", "Portland Timbers"], @stat_tracker.worst_fans
  end

  def test_it_knows_the_lowest_scoring_home_team
    skip
    assert_equal "Houston Dynamo", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_knows_the_hightest_scoring_home_team
    skip
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

  def test_it_can_return_the_best_overall_defense
    skip
    assert_equal "Vancouver Whitecaps FC", @stat_tracker.best_defense
  end


  ######  Move these tests somewhere else

  def test_it_can_return_count_of_games_by_season
    skip
    expected = {
      "20122013"=>5,
      "20162017"=>7,
      "20142015"=>4,
      "20152016"=>5,
      "20132014"=>5,
      "20172018"=>6
      }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_count_total_games_by_team
    skip
    expected = {3=>5, 6=>3, 20=>5, 24=>6,
      16=>3, 14=>2, 5=>4, 19=>4, 28=>4, 54=>4,
      7=>1, 52=>5, 15=>2, 8=>1, 53=>1, 4=>2,
      26=>2, 29=>3, 12=>1, 10=>1, 22=>1, 23=>1,
      17=>1, 21=>1, 25=>1}

    assert_equal expected, @stat_tracker.total_games_by_team
  end

  def test_it_can_count_all_goals_scored_by_team
    skip
    expected = {
      3 => 3,
      12 => 2,
      1 => 4,
      6 => 9
    }
    assert_equal expected, @stat_tracker.all_goals_scored_by_team
  end

  def test_it_can_count_goals_allowed_by_team
    skip
    expected = {
      3 => 5,
      6 => 6,
      12 => 3,
      1 => 4
    }
    assert_equal expected, @stat_tracker.all_goals_allowed_by_team
  end

  def test_it_can_return_team_names_by_id_number
    skip
    assert_equal "Atlanta United", @stat_tracker.team_name_by_id(1)
    assert_equal "LA Galaxy", @stat_tracker.team_name_by_id(17)
  end

  def test_it_knows_all_the_game_ids_in_a_given_season
    assert_equal [2012030221], @stat_tracker.game_ids_in_season(20122013)
    assert_equal [2012030223,2012030224], @stat_tracker.game_ids_in_season(20152016)
  end

  def test_it_knows_coachs_by_season
    expected_1213 = {
      3 => "John Tortorella",
      6 => "Claude Julien"
    }
    expected_1516 = {
      6 => "Josh Thompson",
      3 => "Kelly Dean"
    }
    assert_equal expected_1213, @stat_tracker.head_coaches(20122013)
    assert_equal expected_1516, @stat_tracker.head_coaches(20152016)
  end

  def test_it_knows_wins_by_season
    expected = {
      3 => 1,
      6 => 1
    }
    assert_equal expected, @stat_tracker.wins_in_season(20152016)
  end

  def test_it_can_show_total_wins
    skip
    expected = {
      3 => 0,
      6 => 9,
      5 => 0,
    }
    assert_equal expected, @stat_tracker.total_wins_by_team
  end

  def test_it_can_show_total_loss
    skip
    expected = {
      3 => 5,
      6 => 0,
      5 => 4,
    }
    assert_equal expected, @stat_tracker.total_loss_by_team
  end

  def test_it_can_show_total_ties
    skip
    expected = {
      3 => 0,
      6 => 0,
      5 => 0,
    }
    assert_equal expected, @stat_tracker.total_tie_by_team
  end

  def test_it_can_display_home_or_away_games_by_team
    skip
    expected_home = {
      3 => 2,
      6 => 5,
      5 => 2
    }
    assert_equal expected_home, @stat_tracker.hoa_games_by_team("home")

    expected_away = {
      3 => 3,
      6 => 4,
      5 => 2
    }
    assert_equal expected_away, @stat_tracker.hoa_games_by_team("away")
  end

  def test_it_can_display_all_goals_scored_hoa_by_team
    skip
    expected_home = {
      3 => 4,
      6 => 12,
      5 => 1
    }
    assert_equal expected_home, @stat_tracker.hoa_goals_by_team("home")

    expected_away = {
      3 => 5,
      6 => 11,
      5 => 1
    }
    assert_equal expected_away, @stat_tracker.hoa_goals_by_team("away")
  end

  def test_it_can_display_home_or_away_wins_by_team
    skip
    expected_home = {
      3 => 0,
      6 => 5,
      5 => 0
    }
    assert_equal expected_home, @stat_tracker.hoa_wins_by_team("home")

    expected_away = {
      3 => 0,
      6 => 4,
      5 => 0
    }
    assert_equal expected_away, @stat_tracker.hoa_wins_by_team("away")
  end

  def test_it_can_display_home_or_away_losses_by_team
    skip
    expected_home = {
      3 => 2,
      6 => 0,
      5 => 2
    }
    assert_equal expected_home, @stat_tracker.hoa_loss_by_team("home")

    expected_away = {
      3 => 3,
      6 => 0,
      5 => 2
    }
    assert_equal expected_away, @stat_tracker.hoa_loss_by_team("away")
  end

  def test_it_can_display_home_or_away_ties_by_team
    skip
    expected_home = {
      3 => 0,
      6 => 0,
      5 => 0
    }
    assert_equal expected_home, @stat_tracker.hoa_tie_by_team("home")

    expected_away = {
      3 => 0,
      6 => 0,
      5 => 0
    }
    assert_equal expected_away, @stat_tracker.hoa_tie_by_team("away")
  end

end
